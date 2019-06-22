sudo echo "Starting System Setup..."

#####
echo "Setting default PATH..."
export PATH=/usr/local/bin:/usr/bin:/usr/bin/ruby:/bin:/usr/sbin:/sbin

#####
echo "Moving profiles into place..."
cp -ipvR ./.config/ ~/.config/
cp -ipvR ./.alias-list.sh ~/.alias-list.sh
cp -ipvR ./.bash_profile.sh ~/.bash_profile
cp -ipvR ./.custom-functions.sh ~/.custom-functions.sh
cp -ipvR ./.git-prompt.sh ~/.git-prompt.sh
cp -ipvR ./.gitignore ~/.gitignore
cp -ipvR ./.inputrc.sh ~/.inputrc

#####
echo "Setting system defaults..."
./set-system-defaults.sh
source ~/.bash_profile

#####
echo "Checking for Updates..."
sudo softwareupdate -iaR

#####
echo "Installing Homebrew..."
yes "" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Tapping Casks..."
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap caskroom/versions

echo "Installing Applications..."
brew install awscli
brew install autojump
brew install bash-completion
brew install dfu-util
# brew install docker
brew install ffmpeg
brew install git
brew install gnupg
brew install mas
brew install node
brew install p7zip
brew install python
brew install openssl
brew install ruby
brew install unrar
brew install youtube-dl

# Cask Applications
brew cask install 1password
# brew cask install adobe-acrobat-pro
# brew cask install adobe-acrobat-reader
brew cask install adobe-creative-cloud
brew cask install android-studio
brew cask install arduino
# brew cask install atom
brew cask install balenaetcher
# brew cask install basecamp
brew cask install canary
# brew cask install coda
brew cask install discord
brew cask install eagle
brew cask install firefox
# brew cask install geekbench
# brew cask install github
brew cask install gitkraken
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install gpg-suite
brew cask install handbrake
# brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install istat-menus
brew cask install java
brew cask install journey
brew cask install logitech-gaming-software
brew cask install sketch
# brew cask install sketchup-pro
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install virtualbox
brew cask install vlc
brew cask install wireshark

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
echo "Performing Cleanup..."
brew cleanup --prune=0 --force
rm -rf /Library/Caches/Homebrew/*
echo "Brew installs complete."

#####
echo "Copying User Fonts to system..."
cp -ipvR ./fonts/*.* ~/Library/Fonts/

#####
echo "Installing Node Packages..."
npm install -g aws
npm install -g aws-sdk
npm install -g chai
npm install -g cypress
npm install -g firebase
npm install -g firebase-tools
npm install -g live-server
npm install -g mocha
# npm install -g particle-cli
npm install -g stream-http
npm install -g typescript
npm install -g uuid
npm install -g vue
npm install -g @vue/cli

#####
echo "Installing Particle CLI"
curl -sL https://particle.io/install-cli

#####
echo "Installing Ruby Gems..."
yes "" | sudo gem install bundler
yes "" | sudo gem install sass
yes "" | sudo gem install jekyll
yes "" | sudo gem install rspec

#####
echo "Moving iTerm2 profile into place..."
cp -ipvR ./settings-profiles/iterm-settings.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/settings.json

#####
echo "Moving custom destops into place..."
cp -ipvR ./desktops/* ~/Pictures/

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
echo "Cloning Sublime Text Repository and moving items into place."
cd ~/Library/Application\ Support/
rm -rf Sublime\ Text\ 3/
git clone git@github.com:l-gothberg/sublime-text-3.git
mv sublime-text-3/ Sublime\ Text\ 3/
cd

# Move the log of all setup into
# mv setup-log.txt "setup-log - $(date +%Y_%m_%d__%H%M).txt"

# display a message to indicate the process is finished
echo "**********************************************************"
echo "********************  SETUP COMPLETE  ********************"
echo "**********************************************************"