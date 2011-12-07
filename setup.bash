#!/bin/bash

# Debs
sudo apt-get update

#development environment
sudo apt-get install -y curl vim openjdk-7-jre openjdk-7-jdk mercurial git gedit-plugins octave3.2 gnuplot build-essential ruby-full

# Install git
bash < <( curl -s https://rvm.beginrescueend.com/install/git )

# Install RVM
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )

# Install some Rubies
source "$HOME/.rvm/scripts/rvm"
rvm install 1.9.2

#juicer dependency
sudo apt-get install -y libxml2 libxml2-dev libxslt1-dev

# Install Ruby Gems manually
if ! which gem >/dev/null; then            
  sudo wget http://rubyforge.org/frs/download.php/70696/rubygems-1.3.7.tgz
  sudo tar xvfz rubygems-1.3.7.tgz
  sudo ruby rubygems-1.3.7/setup.rb
  sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
  #sudo gem update --system
  sudo rm -rf rubygems-1.3.7.tgz rubygems-1.3.7
fi

sudo ln -s /usr/bin/gem1.8 /usr/local/bin/gem
sudo ln -s /usr/bin/ruby1.8 /usr/local/bin/ruby
sudo ln -s /usr/bin/rdoc1.8 /usr/local/bin/rdoc
sudo ln -s /usr/bin/ri1.8 /usr/local/bin/ri
sudo ln -s /usr/bin/irb1.8 /usr/local/bin/irb

# Install required gems
required_gems="juicer sprockets"

for required_gem in ${required_gems}
do
  if ! gem list | grep $required_gem >/dev/null; then
  	sudo gem install $required_gem
  fi
done

juicer install yui_compressor
juicer install jslint

#utility
sudo apt-get install -y rar terminator gmountiso meld

#office/work
sudo apt-get install -y checkgmail

#entertainment & graphic app
sudo apt-get install -y vlc vlc-plugin-pulse mozilla-plugin-vlc ubuntu-restricted-extras gstreamer0.10-ffmpeg cheese gimp inkscape

#install adobe air
wget http://airdownload.adobe.com/air/lin/download/2.6/adobeair.deb
sudo dpkg -i adobeair.deb
sudo apt-get install -f
rm adobeair.deb

sudo apt-get upgrade -y

