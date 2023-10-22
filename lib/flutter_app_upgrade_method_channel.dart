import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_app_upgrade_platform_interface.dart';

/// An implementation of [FlutterAppUpgradePlatform] that uses method channels.
class MethodChannelFlutterAppUpgrade extends FlutterAppUpgradePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_app_upgrade');

  @override
  Future<String?> installApk(Map<String, dynamic> info) async {
    final status = await methodChannel.invokeMethod<String>('installApk', info);
    return status;
  }
}
