#include "image_clipboard_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <gdiplus.h>

#include <memory>
#include <sstream>
#include <codecvt>
#include <fstream>
#include <iterator>
#include <locale>
#include <string>
#include <vector>

namespace image_clipboard {

// static
void ImageClipboardPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "image_clipboard",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<ImageClipboardPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

ImageClipboardPlugin::ImageClipboardPlugin() {}

ImageClipboardPlugin::~ImageClipboardPlugin() {}

void ImageClipboardPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else if (method_call.method_name().compare("copyImage") == 0) {
  if (method_call.method_name().compare("copyImage") == 0) {
    const auto &args_map = std::get<flutter::EncodableMap>(*method_call.arguments());
    const auto &image_path_value = args_map.at(flutter::EncodableValue("imagePath"));
    std::string imagePath = std::get<std::string>(image_path_value);

    Gdiplus::GdiplusStartupInput gdiplusStartupInput;
    ULONG_PTR gdiplusToken;
    Gdiplus::GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);

    Gdiplus::Bitmap *bitmap = Gdiplus::Bitmap::FromFile(std::wstring(imagePath.begin(), imagePath.end()).c_str());
    if (bitmap) {
      if (OpenClipboard(NULL)) {
        EmptyClipboard();
        HBITMAP hBitmap;
        bitmap->GetHBITMAP(Gdiplus::Color::Transparent, &hBitmap);
        SetClipboardData(CF_BITMAP, hBitmap);
        CloseClipboard();
      }
      delete bitmap;
    } else {
      result->Error("IMAGE_NOT_FOUND", "Image not found at the given path");
    }

    Gdiplus::GdiplusShutdown(gdiplusToken);
    result->Success(flutter::EncodableValue(true));
             }}
             else {
    result->NotImplemented();
  }
}

}  // namespace image_clipboard
