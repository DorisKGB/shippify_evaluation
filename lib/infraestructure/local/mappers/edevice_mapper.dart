import 'package:shippify_evaluation/core/entities/device.dart';

import '../../../application/base/mapper.dart';

class DeviceToMap extends MapedorService<Device, Map<String, dynamic>> {
  DeviceToMap();

  @override
  Map<String, dynamic> map(Device item) {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = item.name;
    data['distance'] = item.distance;
    data['macAddres'] = item.macAddres;
    return data;
  }
}

class MapToDevice extends MapedorService<Map<String, dynamic>, Device> {
  MapToDevice();

  @override
  Device map(Map<String, dynamic> item) {
    final Device device = Device()
      ..name = item['name']
      ..distance = item['distance']
      ..macAddres = item['macAddres'];
    return device;
  }
}
