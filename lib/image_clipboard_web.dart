// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:image_clipboard/image_clipboard.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


class ImageClipboardWeb extends ImageClipboard {

  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'image_clipboard',
      const StandardMethodCodec(),
      registrar,
    );

    final instance = ImageClipboardWeb();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'copyImage':
        return copyImage(call.arguments['imagePath']);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "The image_clipboard plugin for web doesn't implement the method '${call.method}'",
        );
    }
  }

  @override
  Future<void> copyImage(String imagePath) async {
    // Read the image from the URL and convert it to a byte array
    final response = await html.HttpRequest.request(imagePath,
        responseType: 'blob', method: 'GET', mimeType: 'image/png');
    final reader = html.FileReader();
    final completer = Completer<String>();
    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as String);
    });
    reader.readAsDataUrl(response.response as html.Blob);
    final base64String = await completer.future;

    // Get the Base64 encoded byte array
    final base64Data = base64String.split(',').last;
    final byteArray = base64Decode(base64Data);

    // Convert the Base64 data to a Blob
    html.Blob blob = html.Blob([byteArray], 'image/png');

    // Define the clipboardCopy function
    clipboardCopy(html.Blob imageBlob) {
      final clipboardItemCtor = js.context['ClipboardItem'];
      final clipboardItem = js.JsObject(clipboardItemCtor, [
        js.JsObject.jsify({'image/png': imageBlob})
      ]);
      js.context['navigator']['clipboard']
          .callMethod('write', [js.JsArray()..add(clipboardItem)]);
    }

    // Call the clipboardCopy function
    clipboardCopy(blob);
  }

}
