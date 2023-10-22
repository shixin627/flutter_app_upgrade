import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_upgrade_method_channel.dart';

abstract class FlutterAppUpgradePlatform extends PlatformInterface {
  /// Constructs a FlutterAppUpgradePlatform.
  FlutterAppUpgradePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppUpgradePlatform _instance = MethodChannelFlutterAppUpgrade();

  /// The default instance of [FlutterAppUpgradePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppUpgrade].
  static FlutterAppUpgradePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppUpgradePlatform] when
  /// they register themselves.
  static set instance(FlutterAppUpgradePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> installApk(Map<String, dynamic> info) {
    throw UnimplementedError('installApk() has not been implemented.');
  }
}
