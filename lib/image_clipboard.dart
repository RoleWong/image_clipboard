import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:universal_html/html.dart' as html;

import 'image_clipboard_platform_interface.dart';

typedef WebImageCallback = void Function(html.File imageFile, String blobUrl);

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

  /// Reads an image from the clipboard and saves it to the specified directory with the given file name.
  ///
  /// This function retrieves image data from the clipboard, creates a file with the given [imageFileName]
  /// in the specified [imageSaveDirectory], and writes the image data to the file. If the directory
  /// does not exist, it will be created.
  ///
  /// Note: Due to the limitations of the Flutter Web platform, this function does not work
  /// on the Web. Consider using `addWebPasteListener` on the Web platform.
  ///
  /// [imageSaveDirectory]: The directory where the image file will be saved.
  /// [imageFileName]: The name of the image file to be saved.
  ///
  /// Returns a [File] object representing the saved image file, or null if no image data is available
  /// in the clipboard.
  Future<File?> readImage({required String imageSaveDirectory, required String imageFileName}) async {
    if (!kIsWeb) {
      final bytes = await Pasteboard.image;
      if (bytes != null) {
        final directory = Directory(imageSaveDirectory);
        final filePath = '${directory.path}${Platform.pathSeparator}$imageFileName';
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        final file = File(filePath);
        return await file.writeAsBytes(bytes.toList());
      }
      return null;
    }
  }

  /// Add a paste event listener for the Web platform.
  ///
  /// This function adds a 'paste' event listener to the window object on the Web platform.
  /// When an image is pasted, the provided [onWebImage] callback function will be called with
  /// the pasted image as an [html.File] object and its corresponding [blobUrl].
  ///
  /// Note: This function is intended to be used on the Web platform only.
  ///
  /// [onWebImage]: A callback function that will be called with the pasted image as an [html.File] object
  ///               and its corresponding [blobUrl].
  void addWebPasteListener(WebImageCallback onWebImage) {
    if (kIsWeb) {
      html.window.addEventListener('paste', (event) async {
        final html.ClipboardEvent clipboardEvent = event as html.ClipboardEvent;
        try {
          if (clipboardEvent.clipboardData!.files!.isNotEmpty) {
            html.File imageFile = clipboardEvent.clipboardData!.files![0];
            String blobUrl = html.Url.createObjectUrl(imageFile);
            onWebImage(imageFile, blobUrl);
          }
        } catch (e) {
          // Log the error if reading the image failed.
        }
      });
    }
  }
}
