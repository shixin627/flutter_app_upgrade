import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade_platform_interface.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAppUpgradePlatform
    with MockPlatformInterfaceMixin
    implements FlutterAppUpgradePlatform {

  @override
  Future<String?> installApk() => Future.value('42');
}

void main() {
  final FlutterAppUpgradePlatform initialPlatform = FlutterAppUpgradePlatform.instance;

  test('$MethodChannelFlutterAppUpgrade is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAppUpgrade>());
  });

  test('getPlatformVersion', () async {
    FlutterAppUpgrade flutterAppUpgradePlugin = FlutterAppUpgrade();
    MockFlutterAppUpgradePlatform fakePlatform = MockFlutterAppUpgradePlatform();
    FlutterAppUpgradePlatform.instance = fakePlatform;

    expect(await flutterAppUpgradePlugin.installApk(), '42');
  });
}
