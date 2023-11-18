import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
