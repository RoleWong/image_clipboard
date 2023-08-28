#include "include/image_clipboard/image_clipboard_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "image_clipboard_plugin.h"

void ImageClipboardPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  image_clipboard::ImageClipboardPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
