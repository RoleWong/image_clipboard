
import 'image_clipboard_platform_interface.dart';

class ImageClipboard {
  Future<String?> getPlatformVersion() {
    return ImageClipboardPlatform.instance.getPlatformVersion();
  }

  /// Copies the image located at [imagePath] to the clipboard.
  ///
  /// For web platform, [imagePath] should be a URL.
  /// For other platforms, [imagePath] should be a local file path.
  Future<void> copyImage(String imagePath) async {
    return ImageClipboardPlatform.instance.copyImage(imagePath);
  }
}
