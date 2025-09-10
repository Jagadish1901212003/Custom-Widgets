// import 'dart:developer';
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';

// class DeviceUtility {
//   static void getDeviceInfo() async {
//     if (Platform.isAndroid) {
//       var androidInfo = await DeviceInfoPlugin().androidInfo;
//       var release = androidInfo.version.release;
//       var sdkInt = androidInfo.version.sdkInt;
//       var manufacturer = androidInfo.manufacturer;
//       var model = androidInfo.model;
//       log('Android $release (SDK $sdkInt), $manufacturer $model');
//       //Android 10 (SDK 29), Xiaomi Redmi 8
//     }

//     if (Platform.isIOS) {
//       var iosInfo = await DeviceInfoPlugin().iosInfo;
//       var systemName = iosInfo.systemName;
//       var version = iosInfo.systemVersion;
//       var name = iosInfo.name;
//       var model = iosInfo.model;
//       print('$systemName $version, $name $model');
//       // iOS 13.1, iPhone 11 Pro Max iPhone
//     }
//   }
// }
