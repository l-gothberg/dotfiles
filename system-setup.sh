#####
echo "Setting default PATH..."
echo "export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" >> setup-log.txt
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

#####
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"  >> setup-log.txt

echo "Tapping Casks..."
brew install caskroom/cask/brew-cask >> setup-log.txt
brew tap homebrew/cask-drivers >> setup-log.txt
brew tap homebrew/cask-fonts >> setup-log.txt
brew tap caskroom/versions >> setup-log.txt

echo "Installing Applications..."
brew install autojump
brew install bash-completion
brew install git
brew install node
brew install python
brew install openssl
brew install ruby
brew install youtube-dl

# Cask Applications
#brew cask install adobe-acrobat-pro
brew cask install adobe-acrobat-reader
brew cask install android-studio
brew cask install arduino
brew cask install atom
brew cask install coda
brew cask install discord
brew cask install etcher
brew cask install firefox
brew cask install github
brew cask install gitkraken
brew cask install google-chrome
brew cask install handbrake
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install istat-menus
brew cask install logitech-gaming-software
brew cask install slack
brew cask install steam
brew cask install sublime-text
brew cask install virtualbox
brew cask install vlc

# Fonts
echo "Installing Fonts from web..."
brew cask install font-allerta-stencil
brew cask install font-architects-daughter
brew cask install font-fira-code
brew cask install font-inconsolata
brew cask install font-lato
brew cask install font-nothing-you-could-do
brew cask install font-opendyslexic
brew cask install font-stardos-stencil
brew cask install font-waltograph

echo "Copying User Fonts to system..."
cp -iprv ./Fonts/* ~/Library/Fonts/*

#####
echo "Installing Ruby Gems..."
gem install bundler
gem install rb-applescript

#####
echo "Performing Cleanup..."
brew cleanup --force
rm -rf /Library/Caches/Homebrew/*

#####
echo "Creating simlink to iCloud Folder..."
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/usr/local/bin/iCloud\ Drive

####
echo "Creating simlink for Sublme Text..."
ln -s /Applications/Sublime Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

#####
echo "Moving profiles into place..."
cp -iprv ./alias-list.sh ~/.alias-list
cp -iprv ./bash_profile.sh ~/.bash_profile
cp -iprv ./brew-application-additions ~/.brew-application-additions
cp -iprv ./custom-prompt.sh ~/.custom-prompt
cp -iprv ./git-branch-info.sh ~/.git-bash-info
source ~/.bash_profile