import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'image_clipboard_platform_interface.dart';

/// An implementation of [ImageClipboardPlatform] that uses method channels.
class MethodChannelImageClipboard extends ImageClipboardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('image_clipboard');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Copies the image located at [imagePath] to the clipboard.
  ///
  /// For web platform, [imagePath] should be a URL.
  /// For other platforms, [imagePath] should be a local file path.
  @override
  Future<void> copyImage(String imagePath) async {
    await methodChannel.invokeMethod('copyImage', {'imagePath': imagePath});
  }
}
