import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Unknown';
  final _flutterAppUpgradePlugin = FlutterAppUpgrade();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> installApk() async {
    String status;
    try {
      status = await _flutterAppUpgradePlugin
              .installApk({"fileName": "app-debug"}) ??
          'Unknown status';
    } on PlatformException {
      status = 'Failed to get status.';
    }
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin App Upgrade'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Install Status: $_status\n'),
              ElevatedButton(
                onPressed: installApk,
                child: const Text('Install Apk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
