#!/bin/bash

# Not allowed to run with sudo
if [ "$(whoami)" = "root" ]; then
	echo "Don't run server.bash with sudo."
	exit 1
fi

# update packages
echo "===================update packages======================="
sudo apt-get update

#development environment
sudo apt-get install -y vim openjdk-6-jre openjdk-6-jdk mercurial git-core gedit-plugins build-essential ruby-full 

# Install packages for rvm
echo "===================installing rvm packages======================="
sudo apt-get install -y git-core curl build-essential zlib1g-dev libssl-dev libreadline5-dev

rvm=`type rvm | head -n1`
if [[ "$rvm" != rvm* ]]; then
    echo "=============rvm not existed, installing now============"
    sleep 10
    bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.' >> ~/.bashrc
    source ~/.rvm/scripts/rvm
    
    echo "========================================================"
    echo `type rvm | head -n1`
    echo "========================================================"
    if [[ "$rvm" != rvm* ]]; then
        echo "rvm is not installed correctly"
        exit 1
    fi
    
    # ruby 1.9.2 packages
    echo "=============installing ruby 1.9.2 packages============="
    sudo apt-get install -y build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake

    # Install ruby 1.9.2
    rvm install 1.9.2
    
    if ! gem list | grep "bundler" >/dev/null; then
        gem install bundler
    fi
fi

#juicer dependency
sudo apt-get install -y libxml2 libxml2-dev libxslt1-dev

# Install required gems
required_gems="juicer sprockets"

for required_gem in ${required_gems}
do
  if ! gem list | grep $required_gem >/dev/null; then
	gem install $required_gem
  fi
done

juicer install yui_compressor
juicer install jslint

#utility
sudo apt-get install -y rar terminator furiusisomount meld samba

#entertainment & graphic app
sudo apt-get install -y vlc vlc-plugin-pulse mozilla-plugin-vlc ubuntu-restricted-extras gstreamer0.10-ffmpeg cheese gimp inkscape

#install adobe air
wget http://airdownload.adobe.com/air/lin/download/2.6/adobeair.deb
sudo dpkg -i adobeair.deb
sudo apt-get install -f
rm adobeair.deb

#upgrade package
sudo apt-get upgrade -y

