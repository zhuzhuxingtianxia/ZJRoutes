#
# Be sure to run `pod lib lint ZJRoutes.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJRoutes'
  s.version          = '0.0.1'
  s.summary          = 'ZJRoutes一个轻量的路由框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 实现一个简单的路由框架.
                       DESC

  s.homepage         = 'https://github.com/zhuzhuxingtianxia/ZJRoutes'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ZJ' => '873391579@qq.com' }
  s.source           = { :git => 'https://github.com/zhuzhuxingtianxia/ZJRoutes.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJRoutes/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZJRoutes' => ['ZJRoutes/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.libraries = 'sqlite3.0'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
