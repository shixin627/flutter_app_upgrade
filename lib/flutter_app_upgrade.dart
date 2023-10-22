
import 'flutter_app_upgrade_platform_interface.dart';

class FlutterAppUpgrade {
  Future<String?> installApk(Map<String, dynamic> info) {
    return FlutterAppUpgradePlatform.instance.installApk(info);
  }
}
