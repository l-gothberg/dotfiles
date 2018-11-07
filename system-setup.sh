sudo echo "Starting System Setup..."

#####
echo "Setting default PATH..."
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

#####
echo "Checking for Updates..."
sudo softwareupdate -ia

#####
# allow for restart if needed after updates
restart() {
	read -n 1 -p "Is a restart required to complete updates? (y/n)" restartrequired
	if [ "$restartrequired" == "y" ]; then
		sudo reboot now
	else
		quitprogram
	fi
}

#####
echo "Installing Homebrew..."
yes "" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Tapping Casks..."
brew install caskroom/cask/brew-cask
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap caskroom/versions

echo "Installing Applications..."
brew install autojump
brew install bash-completion
# brew install docker
brew install git
brew install mas
brew install node
brew install python
brew install openssl
brew install ruby
brew install youtube-dl

# Cask Applications
brew cask install 1password
#brew cask install adobe-acrobat-pro
brew cask install adobe-acrobat-reader
brew cask install android-studio
brew cask install arduino
brew cask install atom
brew cask install basecamp
brew cask install coda
brew cask install discord
brew cask install etcher
brew cask install firefox
brew cask install github
brew cask install gitkraken
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install handbrake
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install istat-menus
brew cask install java
brew cask install logitech-gaming-software
brew cask install sketch
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install sublime-text
brew cask install visual-studio
brew cask install virtualbox
brew cask install vlc

# Fonts
echo "Installing Fonts from Web..."
brew cask install font-allerta-stencil
brew cask install font-architects-daughter
brew cask install font-fira-code
brew cask install font-inconsolata
brew cask install font-lato
brew cask install font-nothing-you-could-do
brew cask install font-opendyslexic
brew cask install font-roboto
brew cask install font-stardos-stencil
brew cask install font-waltograph

#####
echo "Copying User Fonts to system..."
cp -iprv ./fonts/*.* ~/Library/Fonts/

#####
echo "Installing Node Packages..."
npm install -g live-server

#####
echo "Installing Ruby Gems..."
yes "" | gem install bundler
# gem install rb-appscript
gem install sass

#####
echo "Performing Cleanup..."
brew cleanup --force
rm -rf /Library/Caches/Homebrew/*

#####
echo "Installing App Store Applications"
./app-store-applications.sh

#####
# echo "Creating simlink to iCloud Folder..."
# ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/usr/local/bin/iCloud\ Drive

#####
echo "Creating simlink for Sublme Text..."
ln -s /Applications/Sublime Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

#####
echo "Creating github folder on Desktop..."
mkdir ~/Desktop/github

#####
echo "Moving profiles into place..."
cp -iprv ./alias-list.sh ~/.alias-list
cp -iprv ./bash_profile.sh ~/.bash_profile
cp -iprv ./brew-application-additions.sh ~/.brew-application-additions
cp -iprv ./custom-prompt.sh ~/.custom-prompt
cp -iprv ./git-branch-info.sh ~/.git-bash-info

#####
# echo "Generating SSH key..."
# ssh-keygen -t rsa -b 4096 -C "leo.gothberg@gmail.com - generated on $(date +%Y_%m_%d__%H%M)"
# echo "Starting SSH Agent..."
# eval "$(ssh-agent -s)"
# echo "Creating SSH config file..."
# echo "Host *" >> ~/.ssh/config
# echo " AddKeysToAgent yes" >> ~/.ssh/config
# echo " UseKeychain yes" >> ~/.ssh/config
# echo " IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
# echo "Adding key to SSH Agent..."
# ssh-add -K ~/.ssh/id_rsa

#####
echo "Setting system defaults..."
./set-system-defaults.sh
source ~/.bash_profile

# Move the log of all setup into
mv setup-log.txt "setup-log - $(date +%Y_%m_%d__%H%M).txt"

# display a message to indicate the process is finished
echo "********************  SETUP COMPLETE  ********************"