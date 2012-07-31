mac_os_x_userdefaults 'Disable "natural" (Lion-style) scrolling' do
  domain 'NSGlobalDomain'
  key 'com.apple.swipescrolldirection'
  value 'false'
  type 'bool'
end

# Menu bar: disable transparency
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Disable smooth scrolling
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Finder: show hidden files by default
#defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

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