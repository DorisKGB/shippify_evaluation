import '../../core/entities/device.dart';

abstract class RDeviceLocal {
  Future<bool> saveDevices(Set<Device> devices);
  Future<List<Device>> getDevices();
}