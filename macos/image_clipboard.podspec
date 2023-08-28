#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint image_clipboard.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'image_clipboard'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for copying images to the clipboard on Web, Windows, and macOS platforms.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://trtc.io/products/chat?utm_source=gfs&utm_medium=link&utm_campaign=%E6%B8%A0%E9%81%93&_channel_track_key=k6WgfCKn'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tencent Cloud' => 'owennwang@tencent.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
