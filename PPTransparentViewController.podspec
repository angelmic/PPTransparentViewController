
Pod::Spec.new do |s|

  s.name                  = "PPTransparentViewController"
  s.version               = "1.0"
  s.summary               = "Transparent View Controller"
  s.homepage              = "https://github.com/"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "richard" => "lichang.liu@gmail.com" }
  s.platform              = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source                = { :git => "https://github.com/angelmic/PPTransparentViewController.git", :tag => "#{s.version}" }
  s.source_files          = "PPTransparentViewController/**/*.{h,m,mm,cpp,c}"
  s.public_header_files   = ['PPTransparentViewController/*.h']
  s.frameworks            = "Foundation","UIKit"
  s.libraries             = "c++", "z"
  s.requires_arc          = true
end
