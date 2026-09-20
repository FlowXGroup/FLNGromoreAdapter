Pod::Spec.new do |s|
  s.name             = 'FLNGromoreAdapter'
  s.version          = '1.0.3'
  s.summary          = 'GroMore custom adapter for FLNAdSDK.'
  s.description      = <<-DESC
    GroMore 自定义 Adapter（开屏 / 插屏 / 激励 / 原生模板）。
    依赖 FLNAdSDK（主工程需通过 Pod 集成）与 Ads-CN（穿山甲 / GroMore）。
  DESC
  s.homepage         = 'https://github.com/FlowXGroup/FLNGromoreAdapter'
  s.license          = { :type => 'Proprietary' }
  s.author           = { 'FlowXGroup' => 'noreply@example.com' }
  s.platform         = :ios, '13.0'
  s.requires_arc     = true

  s.source = {
    :git => 'git@github.com:FlowXGroup/FLNGromoreAdapter.git',
    :tag => s.version.to_s
  }

  s.source_files        = 'Sources/**/*.{h,m}'
  s.public_header_files = 'Sources/**/*.h'

  s.dependency 'FLNAdSDK', '6.2.0.19'
  s.dependency 'Ads-CN/BUAdSDK'
  s.dependency 'Ads-CN/CSJMediation'

  s.frameworks = 'Foundation', 'UIKit'
  s.libraries  = 'c++', 'z', 'sqlite3', 'xml2'
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC',
    'CLANG_ENABLE_MODULES' => 'YES'
  }
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC'
  }
end
