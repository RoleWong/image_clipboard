import Cocoa
import FlutterMacOS

public class ImageClipboardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "image_clipboard", binaryMessenger: registrar.messenger)
    let instance = ImageClipboardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "copyImage":
      let args = call.arguments as! Dictionary<String, Any>
      let imagePath = args["imagePath"] as! String
      let image = NSImage(byReferencingFile: imagePath)
      if (image != nil) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([image!])
        result(true)
      } else {
        result(FlutterError(code: "IMAGE_NOT_FOUND", message: "Image not found at the given path", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}