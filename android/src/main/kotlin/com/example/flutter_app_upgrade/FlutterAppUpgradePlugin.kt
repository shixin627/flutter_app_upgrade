package com.example.flutter_app_upgrade

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat.startActivityForResult
import androidx.core.content.FileProvider

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** FlutterAppUpgradePlugin */
class FlutterAppUpgradePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_app_upgrade")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "installApk") {
            result.success("installing...")
            val fileName = call.argument<String>("fileName")
            installAPK(fileName!!)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

//  private fun getPermission() {
//    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//      if (!packageManager.canRequestPackageInstalls()) {
//        startActivityForResult(
//          Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES)
//            .setData(Uri.parse(String.format("package:%s", context.packageName))), 1
//        )
//      }
//    }
//  }

    private fun installAPK(fileName: String) {
        val apkPath = "/data/user/0/${context.packageName}/cache/$fileName.apk"
        val file = File(apkPath)
        if (file.exists()) {
            Log.d("TAG", "[installAPK]apkPath:$apkPath")
            val intent = Intent(Intent.ACTION_VIEW)
            var uri = uriFromFile(context, File(apkPath))
            Log.d("TAG", "[installAPK]uri:$uri")
            intent.setDataAndType(uri, "application/vnd.android.package-archive")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            try {
                context.startActivity(intent)
            } catch (e: ActivityNotFoundException) {
                e.printStackTrace()
                Log.e("TAG", "Error in opening the file!")
            }
        } else {
            Log.e("TAG", "file not exists")
        }
    }

    private fun uriFromFile(context: Context?, file: File?): Uri? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            FileProvider.getUriForFile(
                context!!, context.packageName + ".provider", file!!
            )
        } else {
            Uri.fromFile(file)
        }
    }
}
