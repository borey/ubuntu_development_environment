#!/bin/bash

####################################################
# This script is mainly for Ubuntu Precise (12.04) #
####################################################

# Not allowed to run with sudo
if [ "$(whoami)" = "root" ]; then
    echo "Don't run server.bash with sudo."
    exit 1
fi

# update packages
echo "===================update packages======================="
sudo apt-get update

#development environment
sudo apt-get install -y vim openjdk-6-jre openjdk-6-jdk mercurial git-core build-essential

# Install rvm packages
sudo apt-get install -y git-core curl build-essential zlib1g-dev libssl-dev libreadline6-dev

# Install ruby requirements
echo -e "\e[0;32mInstalling ruby 1.9.3 packages...\e[0m"
sudo apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion

ruby="ruby-1.9.3-p125"

echo -e "\e[0;32mUpdate rvm to the latest stable version.......\e[0m"
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
source ~/.bashrc
source ~/.rvm/scripts/rvm
rvm reload

rvm=`type rvm | head -n1`
if [[ "$rvm" != rvm* ]]; then
  echo -e "\e[0;31mrvm is not installed correctly, please manually fix it...\e[0m"
  exit 1
fi

rvm install ${ruby}
rvm use ${ruby}

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

#communication
sudo apt-get install -y skype

#utility
sudo apt-get install -y rar terminator furiusisomount meld samba ppa-purge

#entertainment & graphic app
sudo apt-get install -y vlc vlc-plugin-pulse mozilla-plugin-vlc ubuntu-restricted-extras gstreamer0.10-ffmpeg cheese gimp inkscape

#install adobe air
wget http://airdownload.adobe.com/air/lin/download/2.6/adobeair.deb
sudo dpkg -i adobeair.deb
sudo apt-get install -f
rm adobeair.deb

#install gedit plugins
echo "Install gedit plugins"
sudo apt-get install -y gedit-plugins

if [ ! -d $HOME/.gedit ]; then
    mkdir $HOME/.gedit
fi

cd $HOME/.gedit
current_dir=$(pwd)
plugin_dir="$HOME/.local/share/gedit/plugins"

   ##snapopen
if [ ! -d $HOME/.gedit/gedit-snapopen-plugin ]; then
    git clone git://github.com/MadsBuus/gedit-snapopen-plugin.git
    cd ~/.local/share/gedit/plugins
    ln -s $current_dir/gedit-snapopen-plugin/snapopen.plugin .
    ln -s $current_dir/gedit-snapopen-plugin/snapopen .
    
    cd $current_dir
fi

#if [ ! -d $HOME/.gedit/ ]; then
#   current_dir=$(pwd)
#   wget http://nchc.dl.sourceforge.net/project/symbol-browser/symbol-browser/gedit-symbol-browser-plugin/gedit-symbol-browser-plugin-0.1.tar.gz
#   tar xvfz gedit-symbol-browser-plugin-0.1.tar.gz
#   
#   cd $current_dir
#fi

    ##smart highlighting
if [ ! -d $HOME/.gedit/smart_highlighting-3.0.1 ]; then
    wget http://smart-highlighting-gedit.googlecode.com/files/smart_highlighting-3.0.1.tar.gz
    tar xvfz smart_highlighting-3.0.1.tar.gz 
    cd $plugin_dir
    ln -s $current_dir/smart_highlighting-3.0.1/smart_highlight.plugin .
    ln -s $current_dir/smart_highlighting-3.0.1/smart_highlight .
    
    cd $current_dir 
    rm smart_highlighting-3.0.1.tar.gz
fi

#upgrade package
sudo apt-get upgrade -y

