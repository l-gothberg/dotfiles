#!/bin/bash

# ==============================================
# .macos-user-defaults.sh
#
# Commands target the current boot drive
#
# Leo Gothberg <leo.gothberg@gmail.com>
#
# Based on work by Hannes Juutilainen <hjuutilainen@mac.com>
# URL:  https://github.com/hjuutilainen/dotfiles/
#
# SEE ALSO:	https://www.intego.com/mac-security-blog/unlock-the-macos-docks-hidden-secrets-in-terminal/
# ==============================================


function CFPreferencesAppSynchronize() {
	python - <<END
from Foundation import CFPreferencesAppSynchronize
CFPreferencesAppSynchronize('$1')
END
}


# ==============================================
# SYSTEM SETTINGS
# ==============================================


# ==============================================
# Files and folders
# ==============================================

# Show the ~/Library directory
sudo chflags nohidden "${HOME}/Library"

# Don't show the ~/bin directory
if [[ -d "${HOME}/bin" ]]; then
	sudo chflags hidden "${HOME}/bin"
fi

# Avoid creating .DS_Store files on network volumes
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

CFPreferencesAppSynchronize "com.apple.desktopservices"


# ==============================================
# NSGlobalDomain settings
# ==============================================
echo "Setting NSGlobalDomain preferences..."

# Locale
sudo defaults write NSGlobalDomain AppleLocale -string "en_US"
sudo defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
sudo defaults write NSGlobalDomain AppleMetricUnits -bool true
sudo defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# 24-Hour Time
sudo defaults write NSGlobalDomain AppleICUForce12HourTime -bool false
sudo defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Turn off text smoothing for font sizes
sudo defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 4

# Double-click a window's title bar to minimize
sudo defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Minimize"
sudo defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Use smooth scrolling
sudo defaults write NSGlobalDomain AppleScrollAnimationEnabled -bool true

# Enable key repeat
sudo defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set keyboard repeat rate
sudo defaults write NSGlobalDomain KeyRepeat -int 2

# Don't restore windows when quitting or re-opening apps
sudo defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable smart dashes
sudo defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable smart quotes
sudo defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Correct spelling automatically
sudo defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Disable auto-insert period on double space
sudo defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable capitalize words automatically
sudo defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Sidebar icon size: Small
sudo defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Click in the scroll bar to: Jump to clicked location
sudo defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 1

# Don't try to save to iCloud by default
sudo defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Audio and sound effects

# Disable feedback when changing volume
sudo defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false

# Disable flashing the screen when an alert sound occurs (accessibility)
sudo defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false

# Alert volume 50%
sudo defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.6065307

# Enable interface sound effects
sudo defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool true

# Expand save dialog by default
sudo defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Show all filename extensions in Finder Windows
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable keyboard access for all controls
# (i.e. enable Tab in modal dialogs)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable "natural" scroll direction
sudo defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable force click
sudo defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Enable "tap to click" on login screen
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

# Swipe between pages with two fingers
sudo defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# Write changes to disk
CFPreferencesAppSynchronize "NSGlobalDomain"


# ==============================================
# Accessability
# ==============================================
echo "Setting Accessability preferences..."

# Follow the keyboard focus while zoomed in
sudo defaults write com.apple.universialaccess closeViewZoomFollowFocus -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.universialaccess"


# ==============================================
# Application layer firewall
# ==============================================

# Enable ALF
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Allow signed apps
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool true

# Enable logging
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true

# Disable stealth mode
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool false


# ==============================================
# Bluetooth Audio Settings
# ==============================================
echo "Setting Bluetooth Audio Quality preferences..."

# Increase sound quality for Bluetooth headsets
sudo defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
sudo defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
sudo defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
sudo defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
sudo defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
sudo defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
sudo defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.BluetoothAudioAgent"


# ==============================================
# Desktop & Screen Saver
# ==============================================
echo "Setting Desktop & Screen Saver preferences..."

# No translucent menu bar
# sudo defaults write NSGlobalDomain "AppleEnableMenuBarTransparency" -bool false

# Ask for password after 10 seconds
sudo defaults write com.apple.screensaver askForPassword -int 1
sudo defaults write com.apple.screensaver askForPasswordDelay -int 10

# Screen Saver: Shell
sudo defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName -string "Shell" path -string "/System/Library/Screen Savers/Shell.saver" type -int 0

# Show with clock
sudo defaults write com.apple.screensaver showClock -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.screensaver"


# ==============================================
# Disable CD & DVD actions
# ==============================================
echo "Setting CD & DVD preferences..."

# Disable blank CD automatic action.
sudo defaults write com.apple.digihub com.apple.digihub.blank.cd.appeared -dict action 1

# Disable music CD automatic action.
sudo defaults write com.apple.digihub com.apple.digihub.cd.music.appeared -dict action 1

# Disable picture CD automatic action.
sudo defaults write com.apple.digihub com.apple.digihub.cd.picture.appeared -dict action 1

# Disable blank DVD automatic action.
sudo defaults write com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict action 1

# Disable video DVD automatic action.
sudo defaults write com.apple.digihub com.apple.digihub.dvd.video.appeared -dict action 1

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.digihub"


# ==============================================
# Dock & Mission Control
# ==============================================
echo "Setting Dock preferences..."

# Position (left, bottom, right)
sudo defaults write com.apple.dock orientation -string "bottom"

# Pin the dock to a point on the edge (start, middle, end)
sudo defaults write com.apple.Dock pinning -string "middle"

# Enable autohide
sudo defaults write com.apple.dock autohide -bool true

# Reduce autohide delay to zero
sudo defaults write com.apple.dock autohide-delay -int 0

# Speed up show/hide animation
sudo defaults write com.apple.dock autohide-time-modifier -float 0.10

# Enable highlight item on mouseover in stacks
sudo defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Enable magnification
sudo defaults write com.apple.dock magnification -bool true

# Set default icon size to 16 pixels
sudo defaults write com.apple.dock tilesize -int 16

# Set magnified icon size to 128 pixels
sudo defaults write com.apple.dock largesize -int 128

# Enable spring load on all dock items
sudo defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Minimize into application icon
sudo defaults write com.apple.dock minimize-to-application -bool true

# Set animation for minimize (genie, suck, scale)
sudo defaults write com.apple.dock mineffect -string “genie”

# Show indicator lights for open applications in Dock
sudo defaults write com.apple.dock show-process-indicators -bool true

# Only show active apps in the dock
# sudo defaults write com.apple.dock static-only -bool true

# Add “Spacer Tile” to Dock
# sudo defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'

# Add “Recent Items” folder to dock
sudo defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

# Make the Dock immutable
# sudo defaults write com.apple.Dock contents-immutable -bool true

# Enable single app mode (hides all open other applicaions)
# sudo defaults write com.apple.dock single-app -bool true

# Dim icon of hidden app in Dock
sudo defaults write com.apple.dock showhidden -bool true

echo "Setting Mission Control Preferences..."

# Disable "group windows by applicaion"
sudo defaults write com.apple.dock expose-group-by-app -bool false

# Speed up Mission Control animations
sudo defaults write com.apple.dock expose-animation-duration -float 0.10

# Don’t show Dashboard as a space
sudo defaults write com.apple.dock dashboard-in-overlay -bool true

# Hot corners -> bottom left -> start screen saver
sudo defaults write com.apple.dock "wvous-bl-corner" -int 5
sudo defaults write com.apple.dock "wvous-bl-modifier" -int 0

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.dock"


# ==============================================
# Finder
# ==============================================
echo "Setting Finder preferences..."

# Expand the "Open with" and "Sharing & Permissions" panes
sudo defaults write com.apple.finder FXInfoPanesExpanded -dict OpenWith -bool true Privileges -bool true

# Show status bar
sudo defaults write com.apple.finder ShowStatusBar -bool true

# New window points to home
sudo defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Enable window animations and Get Info animations
sudo defaults write com.apple.finder DisableAllAnimations -bool false

# Hide icons for internal hard drives on the desktop
sudo defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

# Show icons for external hard drives, servers, and removable media on the desktop
sudo defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
sudo defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
sudo defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Allow text selection in Quick Look
sudo defaults write com.apple.finder QLEnableTextSelection -bool true

# Set default search scope when searching in Finder
# Search this Mac = SCev
# Search the current folder = SCcf
# Use the previous search scope = SCsp
sudo defaults write com.apple.finder FXDefaultSearchScope -string "SCev"

# Set default finder window view
# icons = icnv
# columns = clmv
# cover flow = Flwv
# list view = Nlsv
sudo defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Group by Kind
sudo defaults write com.apple.finder FXPreferredGroupBy -string "Kind"

# Arrange by Name
sudo defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"

# Empty Trash securely by default
sudo defaults write com.apple.finder EmptyTrashSecurely -bool true

# Automatically remove items in trash after 30 days
sudo defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.finder"


# ==============================================
# Guest Access Disabled  ---  NOTE: This section has issues
# ==============================================
# sudo /usr/sbin/sysadminctl -guestAccount off
# sudo /usr/sbin/sysadminctl -afpGuestAccess off
# sudo /usr/sbin/sysadminctl -smbGuestAccess off


# ==============================================
# Keyboard & Text Replacement
# ==============================================
echo "Setting Keyboard & Text Replacement Preferences..."

# Enable text replacement in (nearly) all applications
sudo defaults write -g WebAutomaticTextReplacementEnabled -bool true


# ==============================================
# Login window
# ==============================================

# Display login window as: List of Users
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool false

# Show shut down etc. buttons
sudo defaults write /Library/Preferences/com.apple.loginwindow PowerOffDisabled -bool false

# Don't show any password hints
sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

# Allow fast user switching
sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool true

# Hide users with UID under 500
sudo defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool true

# Show input menu
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Disable screensaver on login window
sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime -int 0

# Disable automatic login
sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser > /dev/null 2>&1


# ==============================================
# Mouse and trackpad
# ==============================================
echo "Setting Mouse preferences..."

# Secondary click:
# Possible values: OneButton, TwoButton, TwoButtonSwapped
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton

# Smart zoom enabled, double-tap with one finger (set to 0 to disable)
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -int 1

# Double-tap with two fingers to Mission Control (set to 0 to disable)
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -int 3

# Two finger horizontal swipe
# 0 = Swipe between pages with one finger
# 1 = Swipe between pages
# 2 = Swipe between full screen apps with two fingers, swipe between pages with one finger (Default Mode)
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerHorizSwipeGesture -int 2

sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseVerticalScroll -int 1
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll -int 1
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseHorizontalScroll -int 1

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.driver.AppleBluetoothMultitouch.mouse"


echo "Setting Trackpad preferences..."

# Enable "tap to click"
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Enable three finger tap (look up)
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

# Disable three finger drag
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

# Zoom in or out
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true

# Smart zoom, double-tap with two fingers
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true

# Rotate
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true

# Notification Center
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

# Swipe between spaces or full-screen apps
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2

# Three or four finger swipe up for Mission Control
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2

# Pinch with thumb and three or four fingers for Launchpad
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2

sudo defaults write com.apple.dock showMissionControlGestureEnabled -bool true
sudo defaults write com.apple.dock showAppExposeGestureEnabled -bool true
sudo defaults write com.apple.dock showDesktopGestureEnabled -bool true
sudo defaults write com.apple.dock showLaunchpadGestureEnabled -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.driver.AppleBluetoothMultitouch.trackpad"

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.dock"


# ==============================================
# Power Settings
# ==============================================
echo "Setting Power Settings..."
# Battery
sudo pmset -b lidwake 1
sudo pmset -b autopoweroff 1
sudo pmset -b autopoweroffdelay 30
sudo pmset -b standbydelay 900
sudo pmset -b standby 1
sudo pmset -b ttyskeepawake 1
sudo pmset -b hibernatemode 3
sudo pmset -b gpuswitch 2
sudo pmset -b powernap 0
sudo pmset -b hibernatefile /var/vm/sleepimage
sudo pmset -b displaysleep 1
sudo pmset -b womp 1
sudo pmset -b sleep 1
sudo pmset -b tcpkeepalive 1
sudo pmset -b halfdim 1
sudo pmset -b acwake 1
sudo pmset -b lessbright 1
sudo pmset -b disksleep 10

# Power Adapter
sudo pmset -c lidwake 1
sudo pmset -c autopoweroff 1
sudo pmset -c autopoweroffdelay 0
sudo pmset -c standbydelay 5400
sudo pmset -c standby 1
sudo pmset -c ttyskeepawake 1
sudo pmset -c hibernatemode 3
sudo pmset -c gpuswitch 1
sudo pmset -c powernap 1
sudo pmset -c hibernatefile /var/vm/sleepimage
sudo pmset -c displaysleep 60
sudo pmset -c womp 1
sudo pmset -c networkoversleep 0
sudo pmset -c sleep 0
sudo pmset -c tcpkeepalive 1
sudo pmset -c halfdim 1
sudo pmset -c acwake 1
sudo pmset -c disksleep 10


# ==============================================
# System Updates
# ==============================================
echo "Setting Automatic System Update preferences..."

# Check for updates every N days
sudo defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.SoftwareUpdate"

# ==============================================
# Time Zone  ---  NOTE: This section has issues
# ==============================================
# sudo /usr/sbin/systemsetup -settimezone "America/Los_Angeles"
# sudo /usr/sbin/systemsetup -setnetworktimeserver "time.apple.com"
# sudo /usr/sbin/systemsetup -setusingnetworktime on
# sudo /usr/sbin/sysadminctl -automaticTime on


# ==============================================
# APPLICATION SETTINGS
# ==============================================


# ==============================================
# Archive Utility
# ==============================================
echo "Setting Archive Utility preferences..."

# Move archives to trash after extraction
sudo defaults write com.apple.archiveutility "dearchive-move-after" -string "~/.Trash"

# Don't reveal extracted items
sudo defaults write com.apple.archiveutility "dearchive-reveal-after" -bool false

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.archiveutility"


# ==============================================
# Calendar (iCal)
# ==============================================
echo "Setting Calendar preferences..."

# Don't how week numbers
sudo defaults write com.apple.iCal "Show Week Numbers" -bool false

# Show 7 days
sudo defaults write com.apple.iCal "n days of week" -int 7

# Week starts on Sunday
sudo defaults write com.apple.iCal "first day of week" -int 0

# Day starts at 0800
sudo defaults write com.apple.iCal "first minute of work hours" -int 480

# Day ends at 1800
sudo defaults write com.apple.iCal "last minute of work hours" -int 1080

# Show event times
sudo defaults write com.apple.iCal "Show time in Month View" -bool true

# Show events in year view
sudo defaults write com.apple.iCal "Show heat map in Year View" -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.iCal"


# ==============================================
# Contacts (Address Book)
# ==============================================
echo "Setting Contacts preferences..."

# Address format
sudo defaults write com.apple.AddressBook ABDefaultAddressCountryCode -string "us"

# Sort by first name
sudo defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

# Display format "First, Last" (High Sierra)
sudo defaults write NSGlobalDomain NSPersonNameDefaultDisplayNameOrder -int 1

# Disable prefer nicknames
sudo defaults write NSGlobalDomain NSPersonNameDefaultShouldPreferNicknamesPreference -bool false

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.AddressBook"
CFPreferencesAppSynchronize "NSGlobalDomain"


# ==============================================
# Disk Utility
# ==============================================
echo "Setting Disk Utility preferences..."

# Enable the debug menu in Disk Utility
sudo defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
sudo defaults write com.apple.DiskUtility advanced-image-options -bool true

# View -> Show All Devices
sudo defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.DiskUtility"


# ==============================================
# Mail
# ==============================================
echo "Setting Mail preferences..."

# Copy email address as foo@example.com in Mail App
sudo defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.mail"


# ==============================================
# iTunes
# ==============================================
echo "Setting iTunes preferences..."

# Disable Genius, Ping, and Radio Station items in iTunes
sudo defaults write com.apple.iTunes disableGeniusSidebar -bool true
sudo defaults write com.apple.iTunes disablePingSidebar -bool true
sudo defaults write com.apple.iTunes disablePing -bool true
sudo defaults write com.apple.iTunes disableRadio -bool true

# Make CMD+F focus the search input in iTunes
sudo defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add “Target Search Field” “@F”

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.iTunes"


# ==============================================
# Printer Monitor
# ==============================================
# echo "Setting Printer Monitor preferences..."

# Automatically quit printer app once print jobs complete
# sudo defaults write com.apple.print.PrintingPrefs “Quit When Finished” -bool true

# Write changes to disk
# CFPreferencesAppSynchronize "com.apple.print.PrintingPrefs"


# ==============================================
# Safari & WebKit
# ==============================================
echo "Setting Safari & WebKit preferences..."

# Appearance

# Show status bar
sudo defaults write com.apple.Safari ShowStatusBar -bool true

# Show favorites bar
sudo defaults write com.apple.Safari ShowFavoritesBar -bool true
sudo defaults write com.apple.Safari "ShowFavoritesBar-v2" -bool true

# Show tab bar
sudo defaults write com.apple.Safari AlwaysShowTabBar -bool true


# General settings

# Restore last session on launch
sudo defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

# New windows open with: Empty Page
sudo defaults write com.apple.Safari NewWindowBehavior -int 1

# New tabs open with: Empty Page
sudo defaults write com.apple.Safari NewTabBehavior -int 1

# Homepage
sudo defaults write com.apple.Safari HomePage -string "about:blank"

# Don't open "safe" files after downloading
sudo defaults write com.apple.Safari AutoOpenSafeDownloads -bool false


# Tabs settings

# Open pages in tabs instead of windows: automatically
sudo defaults write com.apple.Safari TabCreationPolicy -int 1

# Don't make new tabs active
sudo defaults write com.apple.Safari OpenNewTabsInFront -bool false

# Command-clicking a link creates tabs
sudo defaults write com.apple.Safari CommandClickMakesTabs -bool true


# Autofill settings

# Don't remember passwords
sudo defaults write com.apple.Safari AutoFillPasswords -bool true


# Security settings

# Warn About Fraudulent Websites
sudo defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Enable plug-ins
sudo defaults write com.apple.Safari WebKitPluginsEnabled -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool true

# Enable Java
sudo defaults write com.apple.Safari WebKitJavaEnabled -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool true

# Enable JavaScript
sudo defaults write com.apple.Safari WebKitJavaScriptEnabled -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptEnabled -bool true

# Block pop-up windows
sudo defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Reading list
sudo defaults write com.apple.Safari com.apple.Safari.ReadingListFetcher.WebKit2PluginsEnabled -bool false
sudo defaults write com.apple.Safari com.apple.Safari.ReadingListFetcher.WebKit2LoadsImagesAutomatically -bool false
sudo defaults write com.apple.Safari com.apple.Safari.ReadingListFetcher.WebKit2LoadsSiteIconsIgnoringImageLoadingPreference -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ReadingListFetcher.WebKit2JavaScriptEnabled -bool false


# Privacy settings

# Cookies and website data
# - Always block
# sudo defaults write com.apple.Safari WebKitStorageBlockingPolicy -int 2
# sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2StorageBlockingPolicy -int 2

# Website use of location services
# 0 = Deny without prompting
# 1 = Prompt for each website once each day
# 2 = Prompt for each website one time only
sudo defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 0

# Do not track
sudo defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true


# Notifications

# Don't even ask about the push notifications
sudo defaults write com.apple.Safari CanPromptForPushNotifications -bool false


# Extensions settings

# Update extensions automatically
sudo defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true


# Advanced settings

# Disable Safari’s thumbnail cache for History and Top Sites
sudo defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Make Safari’s search banners default to Contains instead of Starts With
sudo defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Debug menu, Develop menu, and Web Inspector in Safari
sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
sudo defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
sudo defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.Safari"


# ==============================================
# Software Update
# ==============================================

# Enable automatic update check and download
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true

# Enable app update installs
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# Enable system data files and security update installs
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Enable OS X update installs
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true


# ==============================================
# TextEdit
# ==============================================
echo "Setting TextEdit preferences..."

# Use plain text mode for new TextEdit documents
sudo defaults write com.apple.TextEdit RichText -int 0

# Write changes to disk
CFPreferencesAppSynchronize "com.apple.TextEdit"


# ==============================================
# Time Machine
# ==============================================

# Don't offer new disks for backup
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Write changes to disk
CFPreferencesAppSynchronize "/Library/Preferences/com.apple.TimeMachine"


# ==============================================
# Xcode
# ==============================================
echo "Setting Xcode preferences..."

# Always use tabs for indenting
sudo defaults write com.apple.dt.Xcode DVTTextIndentUsingTabs -bool true

# Show tab bar
sudo defaults write com.apple.dt.Xcode AlwaysShowTabBar -bool true


# ==============================================
# COMMANDS
# ==============================================

# Enable HiDPI display modes (requires restart)
echo "Enabling HiDPI display modes..."
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Enable Menubar and Dock “Dark Mode” hotkey (CMD+OPT+CTRL+T)
echo "Enabling Menubar and Dock “Dark Mode” hotkey (CMD+OPT+CTRL+T)..."
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true


echo "Finished..."
echo "Some changes require a restart to take effect."
echo "Restarting system in 5 seconds..."
sleep 5
sudo reboot now
# echo "...SIMULATED RESTART via sudo reboot now"
