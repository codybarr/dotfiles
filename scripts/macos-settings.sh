#!/usr/bin/env bash

# Apply personal macOS preferences for the current user.
set -euo pipefail

# Screenshots: save PNGs to the Desktop without window shadows.
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"

# Finder: use list view and show path and status bars.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Mouse and trackpad: reverse macOS natural scrolling and use right-side
# secondary clicks (the bottom-right corner on the trackpad).
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2

# Spotlight: disable its keyboard shortcuts and indexing on all mounted volumes.
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '{ enabled = 0; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '{ enabled = 0; }'
sudo mdutil -a -i off

# Caps Lock -> Escape. This is the persistent mapping used by the macOS
# Modifier Keys panel for all keyboards (the 0-0-0 device identifier).
defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array \
  '{ HIDKeyboardModifierMappingSrc = 30064771129; HIDKeyboardModifierMappingDst = 30064771113; }'

# Apply the persistent mapping immediately as well as at future logins.
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":30064771129,"HIDKeyboardModifierMappingDst":30064771113}]}'

# Remove the legacy helper used before the native persistent mapping.
legacy_agent="$HOME/Library/LaunchAgents/com.codybarr.caps-lock-escape.plist"
launchctl bootout "gui/$UID/com.codybarr.caps-lock-escape" 2>/dev/null || true
rm -f "$legacy_agent"

# Reload apps that cache these preferences.
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS settings applied."
