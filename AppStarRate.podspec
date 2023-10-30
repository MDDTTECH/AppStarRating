Pod::Spec.new do |s|
  s.name             = 'AppStarRate'
  s.version          = '0.1.0'
  s.summary          = 'Custom App Rating'
  s.description      = <<-DESC
  s.homepage         = 'https://github.com/MDDTTECH/AppStarRating'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "MDDT" => "hello@mddt.tech" }
#  s.source           = { :git => 'https://github.com/MDDTTECH/AppStarRate.git', :tag => s.version.to_s }
  spec.social_media_url   = "https://t.me/aleksundervolkovnotes"
  s.ios.deployment_target = '10.0'
  spec.source_files  = 'Sources/**/*.{swift,h,m}'
  s.frameworks = 'UIKit', 'StoreKit'
  spec.dependency 'Blurberry', "~> 0.1.0'
  spec.dependency 'SnapKit', '~> 5.6.0'
end
