//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <printing/printing_plugin.h>
#include <quick_usb/quick_usb_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) printing_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PrintingPlugin");
  printing_plugin_register_with_registrar(printing_registrar);
  g_autoptr(FlPluginRegistrar) quick_usb_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "QuickUsbPlugin");
  quick_usb_plugin_register_with_registrar(quick_usb_registrar);
}
