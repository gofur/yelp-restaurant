import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> requestPermission(Permission permission) async {
    var res = await permission.request();
    return res == PermissionStatus.granted;
  }

  Future<bool> isGranted(Permission permission) async {
    var status = await permission.status;
    return status == PermissionStatus.granted;
  }
}
