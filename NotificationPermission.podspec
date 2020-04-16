#
# Be sure to run `pod lib lint NotificationPermission.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NotificationPermission'
  s.version          = '0.2.0'
  s.summary          = "To access UNUserNotificationCenter and will be used to create a UNNotification and it will be used to notify the user"
  s.description      = "The NotificationPermission is a completely customizable helper class that can be used in any iOS app to access UNUserNotificationCenter."
  s.homepage         = 'https://github.com/hadanischal/NotificationPermission.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Nischal Hada" => "hadanischal@gmail.com" }
  s.source           = { :git => 'https://github.com/hadanischal/NotificationPermission.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/neeschalhada'

  s.swift_version = '5.2'
  s.ios.deployment_target = '12.0'
  s.source_files = 'NotificationPermission/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NotificationPermission' => ['NotificationPermission/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'RxSwift', '~> 5.1.1'
  s.dependency 'RxCocoa', '~> 5.1.1'

end
