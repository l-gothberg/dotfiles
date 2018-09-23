sudo echo "Starting System Setup..."

#####
echo "Setting default PATH..."
echo "export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" >> setup-log.txt
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

#####
echo "Installing Homebrew..."
echo "Installing Homebrew..." >> setup-log.txt
yes "" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" >> setup-log.txt

echo "Tapping Casks..."
echo "Tapping Casks..." >> setup-log.txt
brew install caskroom/cask/brew-cask >> setup-log.txt
brew tap homebrew/cask-drivers >> setup-log.txt
brew tap homebrew/cask-fonts >> setup-log.txt
brew tap caskroom/versions >> setup-log.txt

echo "Installing Applications..."
echo "Installing Applications..." >> setup-log.txt
brew install autojump >> setup-log.txt
brew install bash-completion >> setup-log.txt
brew install git >> setup-log.txt
brew install mas >> setup-log.txt
brew install node >> setup-log.txt
brew install python >> setup-log.txt
brew install openssl >> setup-log.txt
brew install ruby >> setup-log.txt
brew install youtube-dl >> setup-log.txt

# Cask Applications
#brew cask install adobe-acrobat-pro
brew cask install adobe-acrobat-reader >> setup-log.txt
brew cask install android-studio >> setup-log.txt
brew cask install arduino >> setup-log.txt
brew cask install atom >> setup-log.txt
brew cask install coda >> setup-log.txt
brew cask install discord >> setup-log.txt
brew cask install etcher >> setup-log.txt
brew cask install firefox >> setup-log.txt
brew cask install github >> setup-log.txt
brew cask install gitkraken >> setup-log.txt
brew cask install google-chrome >> setup-log.txt
brew cask install handbrake >> setup-log.txt
brew cask install intellij-idea-ce >> setup-log.txt
brew cask install iterm2 >> setup-log.txt
brew cask install istat-menus >> setup-log.txt
brew cask install logitech-gaming-software >> setup-log.txt
brew cask install slack >> setup-log.txt
brew cask install steam >> setup-log.txt
brew cask install sublime-text >> setup-log.txt
brew cask install virtualbox >> setup-log.txt
brew cask install vlc >> setup-log.txt

# Fonts
echo "Installing Fonts from Web..."
echo "Installing Fonts from Web..." >> setup-log.txt
brew cask install font-allerta-stencil >> setup-log.txt
brew cask install font-architects-daughter >> setup-log.txt
brew cask install font-fira-code >> setup-log.txt
brew cask install font-inconsolata >> setup-log.txt
brew cask install font-lato >> setup-log.txt
brew cask install font-nothing-you-could-do >> setup-log.txt
brew cask install font-opendyslexic >> setup-log.txt
brew cask install font-stardos-stencil >> setup-log.txt
brew cask install font-waltograph >> setup-log.txt

#####
echo "Copying User Fonts to system..."
echo "Copying User Fonts to system..." >> setup-log.txt
cp -iprv ./Fonts/* ~/Library/Fonts/* >> setup-log.txt

#####
echo "Installing Ruby Gems..."
echo "Installing Ruby Gems..." >> setup-log.txt
gem install bundler >> setup-log.txt
gem install rb-applescript >> setup-log.txt
gem install sass >> setup-log.txt

#####
echo "Performing Cleanup..."
echo "Performing Cleanup..." >> setup-log.txt
brew cleanup --force >> setup-log.txt
rm -rf /Library/Caches/Homebrew/* >> setup-log.txt

#####
echo "Creating simlink to iCloud Folder..."
echo "Creating simlink to iCloud Folder..." >> setup-log.txt
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/usr/local/bin/iCloud\ Drive >> setup-log.txt

####
echo "Creating simlink for Sublme Text..."
echo "Creating simlink for Sublme Text..." >> setup-log.txt
ln -s /Applications/Sublime Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl >> setup-log.txt

#####
echo "Moving profiles into place..."
echo "Moving profiles into place..." >> setup-log.txt
cp -iprv ./alias-list.sh ~/.alias-list >> setup-log.txt
cp -iprv ./bash_profile.sh ~/.bash_profile >> setup-log.txt
cp -iprv ./custom-prompt.sh ~/.custom-prompt >> setup-log.txt
cp -iprv ./git-branch-info.sh ~/.git-bash-info >> setup-log.txt

#####
echo "Installing App Store Applications"
echo "Installing App Store Applications" >> setup-log.txt
./app-store-applications.sh

#####
echo "Generating SSH key..."
echo "Generating SSH key..." >> setup-log.txt
ssh-keygen -t rsa -b 4096 -C "leo.gothberg@gmail.com - generated on $(date +%Y_%m_%d__%H%M)"
echo "Starting SSH Agent..."
echo "Starting SSH Agent..." >> setup-log.txt
eval "$(ssh-agent -s)"
echo "Creating SSH config file..."
echo "Creating SSH config file..." >> setup-log.txt
echo "Host *" >> ~/.ssh/config
echo " AddKeysToAgent yes" >> ~/.ssh/config
echo " UseKeychain yes" >> ~/.ssh/config
echo " IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
echo "Adding key to SSH Agent..."
echo "Adding key to SSH Agent..." >> setup-log.txt
ssh-add -K ~/.ssh/id_rsa


#####
echo "Setting system defaults..."
echo "Setting system defaults..." >> setup-log.txt
./set-system-defaults.sh
source ~/.bash_profile >> setup-log.txt

# Move the log of all setup into
mv setup-log.txt "setup-log - $(date +%Y_%m_%d__%H%M).txt"

# display a message to indicate the process is finished
echo "********************  SETUP COMPLETE  ********************"