#!/bin/bash

# Debs
sudo apt-get update

#development environment
sudo apt-get install -y curl vim openjdk-6-jre mercurial git gedit-plugins octave3.2 gnuplot 

# Install git
bash < <( curl -s https://rvm.beginrescueend.com/install/git )

# Install RVM
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )

# Install some Rubies
source "$HOME/.rvm/scripts/rvm"
rvm install 1.9.2


#utility
sudo apt-get install -y rar terminator gmountiso

#office/work
sudo apt-get install -y checkgmail

#entertainment app
sudo apt-get install -y vlc vlc-plugin-pulse mozilla-plugin-vlc ubuntu-restricted-extras gstreamer0.10-ffmpeg cheese


sudo apt-get upgrade -y

