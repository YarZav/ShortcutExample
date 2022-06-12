source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
platform :ios, '13.0'

def openSourcePods
  pod 'SwiftLint', '0.47.1'
end

target 'ShortcutExample' do
  openSourcePods

  target 'ShortcutExampleTests' do
    inherit! :search_paths
  end
end