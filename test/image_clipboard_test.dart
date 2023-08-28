import 'package:flutter_test/flutter_test.dart';
import 'package:image_clipboard/image_clipboard.dart';
import 'package:image_clipboard/image_clipboard_platform_interface.dart';
import 'package:image_clipboard/image_clipboard_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockImageClipboardPlatform
    with MockPlatformInterfaceMixin
    implements ImageClipboardPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ImageClipboardPlatform initialPlatform = ImageClipboardPlatform.instance;

  test('$MethodChannelImageClipboard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelImageClipboard>());
  });

  test('getPlatformVersion', () async {
    ImageClipboard imageClipboardPlugin = ImageClipboard();
    MockImageClipboardPlatform fakePlatform = MockImageClipboardPlatform();
    ImageClipboardPlatform.instance = fakePlatform;

    expect(await imageClipboardPlugin.getPlatformVersion(), '42');
  });
}
