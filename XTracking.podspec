Pod::Spec.new do |s|
    s.name             = 'XTracking'
    s.version          = '1.0.1'
    s.summary          = "本项目可实现UIKit控件的点击 & 曝光自动跟踪功能"
    s.homepage         = 'https://github.com/liuxc123/XTracking'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'liuxc123' => 'lxc_work@126.com' }
    s.source           = { :git => 'https://github.com/liuxc123/XTracking.git', :tag => s.version.to_s }
    s.platform         = :ios
    s.requires_arc     = true
    s.ios.deployment_target = '9.0'
    
    s.source_files = 'Source/*'
    
    s.subspec 'Overall' do |all|
        all.source_files = 'Source/Overall/*'
        all.frameworks = 'UIKit', 'Foundation'
    end
    
    s.subspec 'Page' do |ss|
        ss.source_files = 'Source/Page/*'
        ss.dependency 'XTracking/Overall'
    end
  
    s.subspec 'Expose' do |ss|
        ss.source_files = 'Source/Expose/*'
        ss.dependency 'XTracking/Overall'
        ss.dependency 'KVOController'
    end
  
    s.subspec 'Action' do |ss|
        ss.source_files = 'Source/Action/*'
        ss.dependency 'XTracking/Overall'
    end
    
end
