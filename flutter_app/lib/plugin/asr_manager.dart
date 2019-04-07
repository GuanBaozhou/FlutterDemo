//接口实现
//管保洲
//2019-04-07
import 'package:flutter/services.dart';

class AsrManager {
  static const MethodChannel _channel = const MethodChannel("asr_plugin");

  //开始录音
  static Future<String> start({Map params}) async {
    return _channel.invokeMethod("start", params ?? {});
  }

  //停止录音
  static Future<String> stop({Map params}) async {
    return _channel.invokeMethod("stop");
  }

//取消录音
  static Future<String> cancel({Map params}) async {
    return _channel.invokeMethod("cancel");
  }
}
