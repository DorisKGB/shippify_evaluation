import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shippify_evaluation/application/repositories/r_device_local.dart';
import 'package:shippify_evaluation/core/entities/device.dart';

import 'mappers/edevice_mapper.dart';

enum KeyUser { devices }

class RDeviceLocalImp implements RDeviceLocal {
  @override
  Future<List<Device>> getDevices() async {
    try {
      var data = (await SharedPreferences.getInstance())
          .getString(KeyUser.devices.toString());
      if (data != null) {
        return MapToDevice().transformList((jsonDecode(data) as List<dynamic>)
          .map((dynamic e) => Map<String, dynamic>.from(e))
          .toList());
      }      
      return [];
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return Future.error(e.toString(), stackTrace);
    }
  }

  @override
  Future<bool> saveDevices(Set<Device> mDeviceView) async {
    try {
      var device = DeviceToMap().transformList(mDeviceView.toList());
      String data = jsonEncode(device);
      await (await SharedPreferences.getInstance())
          .setString(KeyUser.devices.toString(), data);
      return true;
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return false;
    }
  }
}
