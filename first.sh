#!/bin/bash

# Delete thunderbird
sudo apt -y remove thunderbird

# Update APT
sudo apt update
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean

# Change names of directories
LANG=C xdg-user-dirs-gtk-update

# Install fcitx-mozc
sudo apt -y install fcitx-mozc
echo "Please check https://students-tech.blog/post/mozc-autostart.html"

# Install Enpass
echo "deb https://apt.enpass.io/  stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
sudo apt update
sudo apt -y install enpass

# Install Brave
sudo apt -y install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt -y install brave-browser

# Install GitHub CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt -y install gh

# Install ROS (Noetic)
sudo apt -y install curl
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install -y ros-noetic-desktop-full
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source /opt/ros/noetic/setup.bash
sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential python3-roslaunch python3-osrf-pycommon python3-catkin-tools python3-pip vim
sudo rosdep init
rosdep update

# Install mirage
echo "Please check http://blawat2015.no-ip.com/~mieki256/diary/202105024.html"
mkdir -p ~/Downloads/mirage
cd ~/Downloads/mirage
wget http://old-releases.ubuntu.com/ubuntu/pool/main/e/exiv2/libexiv2-14_0.25-4ubuntu2.2_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/p/pyexiv2/python-pyexiv2_0.3.2-9_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-gtk2_2.24.0-6_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/m/mirage/mirage_0.9.5.2-1_amd64.deb
sudo apt-get install ./*.deb

# Install Tweaks
sudo apt install gnome-tweaks

# Re-install NVIDIA GPU Driver
sudo apt -y purge nvidia-*
sudo apt -y purge cuda-*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
ubuntu-drivers devices
echo ""
echo "Please install the recommended driver with APT then please reboot."
