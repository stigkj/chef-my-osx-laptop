mac_os_x_userdefaults 'Disable "natural" (Lion-style) scrolling' do
  domain 'NSGlobalDomain'
  key 'com.apple.swipescrolldirection'
  value 'false'
  type 'bool'
end

mac_os_x_userdefaults 'Menu bar: disable transparency' do
  domain 'NSGlobalDomain'
  key 'AppleEnableMenuBarTransparency'
  value 'false'
  type 'bool'
end

mac_os_x_userdefaults 'Finder: show hidden files by default' do
  domain 'com.apple.finder'
  key 'AppleShowAllFiles'
  value 'true'
  type 'bool'
end

mac_os_x_userdefaults 'Finder: show all filename extensions' do
  domain 'NSGlobalDomain'
  key 'AppleShowAllExtensions'
  value 'true'
  type 'bool'
end

mac_os_x_userdefaults 'Remove the auto-hiding Dock delay' do
  domain 'com.apple.dock'
  key 'autohide-delay'
  value '0'
  type 'float'
end

mac_os_x_userdefaults 'Remove the animation when hiding/showing the Dock' do
  domain 'com.apple.dock'
  key 'autohide-time-modifier'
  value '0'
  type 'float'
end

mac_os_x_userdefaults 'Automatically hide and show the Dock' do
  domain 'com.apple.dock'
  key 'autohide'
  value 'true'
  type 'bool'
end

# Look at this: https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Look at http://chris-gerke.blogspot.no/2012/03/mac-osx-soe-master-image-day-6.html

# Have function keys work as regular function keys and not their special features
# defaults write -g com.apple.keyboard.fnState -boolean true

# Remove a keyboard shortcut, can use the same for registering shortcuts
# defaults write -g NSUserKeyEquivalents -dict-add "Special Characters..." nul

# TODO Enable access for assistive devices
# sudo touch /private/var/db/.AccessibilityAPIEnabled

# TODO turn off remote

# TODO use function keys as standard function keys

# TODO Turn off Resume (new Lion feature) on a per app basis
# http://osxdaily.com/2011/08/01/turn-off-resume-per-app-in-mac-os-x-lion/

# Enable the 2D Dock
#defaults write com.apple.dock no-glass -bool true

# Disable other variants-popup
#defaults write -g ApplePressAndHoldEnabled -bool NO

#Unhide ~/Library
#chflags nohidden ~/Library

# Disable smooth scrolling
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false


# Finder: show status bar
#defaults write com.apple.finder ShowStatusBar -bool true

# Finder: allow text selection in Quick Look
#defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
#defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
#defaults write com.apple.frameworks.diskimages skip-verify -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
#defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
#defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
#defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true