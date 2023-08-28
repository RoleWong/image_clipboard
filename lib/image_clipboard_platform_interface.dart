import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'image_clipboard_method_channel.dart';

abstract class ImageClipboardPlatform extends PlatformInterface {
  /// Constructs a ImageClipboardPlatform.
  ImageClipboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImageClipboardPlatform _instance = MethodChannelImageClipboard();

  /// The default instance of [ImageClipboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelImageClipboard].
  static ImageClipboardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImageClipboardPlatform] when
  /// they register themselves.
  static set instance(ImageClipboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Copies the image located at [imagePath] to the clipboard.
  ///
  /// For web platform, [imagePath] should be a URL.
  /// For other platforms, [imagePath] should be a local file path.
  Future<void> copyImage(String imagePath) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
