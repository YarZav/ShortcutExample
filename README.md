# ShortcutExample
Shortcut test project

# Install

Xcode

Brew (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"]

brew install xcodegen

sudo gem install cocoapods

# Generate

xcodegen generate

pod install

# Build

open *.xcworkspace via Xcode

Tap CMD+B

# Run

open *.xcworkspace via Xcode

tap CMD+R

#Architecture

Coordinator Flow Pattern
Viper Pattern
Core Data
Module architecture

#Structure
- ShortcutExample
  - Assets.xcassets (Images)
  - Localizable.strings (EN strings with key-value)
  - ShortcutExample.xcdatamodeld (Data base)
  - AppDelegate (App delegate with main function)
  - AppConfiguration (Application dependencies)
  - Common (extension for String, UITableView, UITableViewCell, UIIMageView etc.)
  - Modules (All screens)
    - AppCoordinatorFlow (Coordinator flow for applicaiton: Move to TabBar -> Show Comics coordinatow flow and Favorite list coordinator flow)
    - MainSceen (UITabBarController)
    - ComicSceen (All screens for Comics: fetcjing data and store in favorite list)
    - FavoriteSceen (All screens for Favorite list)
