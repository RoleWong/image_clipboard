//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <image_clipboard/image_clipboard_plugin.h>
#include <pasteboard/pasteboard_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) image_clipboard_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ImageClipboardPlugin");
  image_clipboard_plugin_register_with_registrar(image_clipboard_registrar);
  g_autoptr(FlPluginRegistrar) pasteboard_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PasteboardPlugin");
  pasteboard_plugin_register_with_registrar(pasteboard_registrar);
}
