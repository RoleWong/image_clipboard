
# image_clipboard

A Flutter plugin for copying images to the clipboard on Web, Windows, and macOS platforms. 

This plugin was initially developed by the [Tencent Cloud Chat](https://trtc.io/products/chat?utm_source=gfs&utm_medium=link&utm_campaign=%E6%B8%A0%E9%81%93&_channel_track_key=k6WgfCKn) Flutter team for use in the [Tencent Cloud Chat Flutter TUIKit](https://www.tencentcloud.com/document/product/1047/50059?from=pub) chat component library and is now available for everyone to use.

## Usage

To use this plugin, add `image_clipboard` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

### Example

```dart
import 'package:flutter/material.dart';
import 'package:image_clipboard/image_clipboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Image Clipboard Example')),
        body: Center(child: CopyImageButton()),
      ),
    );
  }
}

class CopyImageButton extends StatelessWidget {
  final imageClipboard = ImageClipboard();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final imagePath = 'path/to/your/image'; // Replace with your image path or URL
        await imageClipboard.copyImage(imagePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image copied to clipboard')),
        );
      },
      child: Text('Copy Image'),
    );
  }
}
```

## Supported Platforms

- Web
- Windows
- macOS

Please note that this plugin does not currently support Android, iOS, or Linux platforms.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue on [GitHub](https://github.com/your_github_username/image_clipboard/issues).

## License

This plugin is available under the [MIT License](https://opensource.org/licenses/MIT).
