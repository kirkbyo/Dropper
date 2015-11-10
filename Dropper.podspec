#
# Be sure to run `pod lib lint Dropper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Dropper"
  s.version          = "2.2"
  s.summary          = "Customizable Swift Dropdown Menu "

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Highly customizable Swift Dropdown Menu. Easy to use and to set up. 
                       DESC

  s.homepage         = "https://github.com/kirkbyo/Dropper"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "kirkbyo" => "ozzie@kirkbyo.com" }
  s.source           = { :git => "https://github.com/kirkbyo/Dropper.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kirkbyo_'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Dropper' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
