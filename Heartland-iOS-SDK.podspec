#
# Be sure to run `pod lib lint Heartland-iOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Heartland-iOS-SDK"
  s.version          = "1.1.10"
  s.summary          = "Secure Tokenized Payments by Heartland Payment Systems."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  Secure Tokenized Payments for iOS by Heartland Payment Systems.
                       DESC

  s.homepage         = "https://github.com/hps/heartland-ios"
  s.license          = 'EULA'
  s.author           = { "Heartland Developer Portal" => "EntApp_DevPortal@e-hps.com" }
  s.source           = { :git => "https://github.com/hps/heartland-ios.git", :tag => s.version.to_s }
 

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Heartland-iOS-SDK' => ['Pod/Assets/*.png', 'Pod/Assets/*.xib']
  }

  s.frameworks = 'UIKit'

  s.frameworks = 'UIKit'
  s.dependency 'XMLDictionary'
  s.dependency 'VitalSDK'
  s.dependency 'BBPOS', '1.0.1'
  s.dependency 'EMVCore'
  s.dependency 'BBDeviceSPoC'
  s.swift_version = '5.0'
end
