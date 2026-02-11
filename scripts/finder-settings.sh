#!/bin/bash

# Set Finder's default view style to list view, show path bar, and show status bar
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Restart Finder to apply changes
killall Finder
