Pod::Spec.new do |s|
  s.name             = 'AppStarRate'
  s.version          = '0.1.1'
  s.summary          = 'Custom App Rating'
  s.homepage         = 'https://github.com/MDDTTECH/AppStarRate'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "MDDT" => "hello@mddt.tech" }
  s.source           = { :git => 'https://github.com/MDDTTECH/AppStarRate.git', :tag => s.version.to_s }
  s.social_media_url = "https://t.me/aleksundervolkovnotes"
  s.ios.deployment_target = '10.0'
  s.source_files  = 'Sources/**/*.{swift,h,m}'
  s.frameworks = 'UIKit', 'StoreKit'
  s.dependency 'Blurberry', '~> 0.1.0'
  s.dependency 'SnapKit', '~> 5.6.0'
  s.swift_version     = "5.0"
  s.ios.deployment_target = "13.0"
end
