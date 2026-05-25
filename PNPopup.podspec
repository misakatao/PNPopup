#
# Be sure to run `pod lib lint PNPopup.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PNPopup'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight, customizable popup presentation library for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PNPopup provides customizable popup presentation for iOS apps.
It supports ActionSheet-style (bottom slide-up with spring animation)
and Alert-style (center pop-in with scale animation) presentations,
along with lifecycle callbacks, touch-to-dismiss, and optional
navigation controller wrapping. Pure UIKit with zero dependencies.
                       DESC

  s.homepage         = 'https://github.com/misakatao/PNPopup'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'misaka' => 'misakatao' }
  s.source           = { :git => 'https://github.com/misakatao/PNPopup.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'PNPopup/Classes/**/*'

  # s.resource_bundles = {
  #   'PNPopup' => ['PNPopup/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
