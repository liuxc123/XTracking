#
# Be sure to run `pod lib lint xTracking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XTracking'
  s.version          = '1.0.0'
  s.summary          = 'XTracking'
  s.description      = <<-DESC
    本项目可实现UIKit控件的点击 & 曝光自动跟踪功能
                       DESC
  s.homepage         = 'https://github.com/liuxc123/XTracking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/XTracking.git'}
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'Source/*'
  
  s.subspec 'Overall' do |all|
    all.source_files = 'Source/Overall/*'
    all.frameworks = 'UIKit', 'Foundation'
  end
  
  s.subspec 'Page' do |sp|
    sp.source_files = 'Source/Page/*'
    sp.dependency 'xTracking/Overall'
  end
  
  s.subspec 'Expose' do |se|
    se.source_files = 'Source/Expose/*'
    se.dependency 'xTracking/Overall'
    se.dependency 'KVOController'
  end
  
  s.subspec 'Action' do |sa|
    sa.source_files = 'Source/Action/*'
    sa.dependency 'xTracking/Overall'
  end
  
end
