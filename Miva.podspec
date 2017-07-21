#
Pod::Spec.new do |s|

  s.name             = 'Miva'
  s.version          = '0.1.1'
  s.summary          = 'A Swift Download Library'
 
  s.description      = <<-DESC
A networking library that fetches, caches, and displays images, JSON, files via HTTP in Swift.
                       DESC
 
  s.homepage         = 'https://github.com/furqanmk/Miva'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Furqan Muhammad Khan' => 'furqanmk@outlook.com' }
  s.source           = { :git => 'https://github.com/furqanmk/Miva.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'
  s.source_files = 'Miva/*.{swift,h}'
 
end
