Pod::Spec.new do |spec|

  spec.name         = "SwiftDay"
  spec.version      = "0.0.2"
  spec.summary      = " rewrite dayjs by swift"
  spec.description  = <<-DESC
  try to rewrite dayjs by swift, methods same as dayjs
                   DESC
  spec.homepage     = "https://github.com/xo1988/SwiftDay.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "wangyu" => "947936711@qq.com" }
  spec.source       = { :git => "https://github.com/xo1988/SwiftDay.git", :tag => "#{spec.version}" }
  spec.swift_versions = "5.0"
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.10"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"
  spec.source_files  = "Source", "Source/*.swift"
end
