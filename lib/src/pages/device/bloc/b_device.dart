import 'package:rxdart/rxdart.dart';
import 'package:shippify_evaluation/core/entities/device.dart';
import 'package:shippify_evaluation/src/models/m_device_view.dart';

import '../../../../application/repositories/r_device_local.dart';
import '../../../utils/bloc_pattern/bloc_base.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BDevice extends BlocBase {
  BDevice(this.rDeviceLocal) {
    getAllDevices();
  }
  final RDeviceLocal rDeviceLocal;

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final BehaviorSubject<List<MDeviceView>?> _listDevice =
      BehaviorSubject<List<MDeviceView>?>();
  List<MDeviceView>? get listDevice => _listDevice.valueOrNull ?? [];

  Stream<List<MDeviceView>?> get outListDevice => _listDevice.stream;
  Function(List<MDeviceView>?) get inListDevice => _listDevice.sink.add;

  Future<List<Device>> getBlueDevices() async {
    try {
      List<ScanResult> devices =
          await flutterBlue.startScan(timeout: const Duration(seconds: 4));
      final List<Device> listDeviceAux = [];
      for (ScanResult dev in devices) {
        listDeviceAux.add(Device()
          ..name = dev.device.name.isEmpty ? "Sin nombre" : dev.device.name
          ..macAddres = dev.device.id.id
          ..distance = dev.rssi.toString());
      }
      return listDeviceAux;
      //    inListDevice(listDeviceAux);
    } catch (e) {
      return [];
    }
  }

  Future<List<Device>> getLocalDevices() async {
    try {
      return await rDeviceLocal.getDevices();
    } catch (e) {
      return [];
    }
  }

  Future<void> getAllDevices() async {
    try {
      inListDevice(null);
      final List<MDeviceView> mDeviceView = [];
      final blueDevices = await getBlueDevices();
      final localDevices = await getLocalDevices();
      for (Device ld in localDevices) {
        final dv = Device()
          ..name = ld.name
          ..distance = ld.distance
          ..macAddres = ld.macAddres;
        mDeviceView.add(MDeviceView()
          ..device = dv
          ..save = true);
      }
      for (Device bd in blueDevices) {
        var isSave = false;
        for (MDeviceView md in mDeviceView) {
          if (md.device?.macAddres == bd.macAddres) {
            isSave = true;
            break;
          }
        }
        if (!isSave) {
          final dv = Device()
            ..name = bd.name
            ..distance = bd.distance
            ..macAddres = bd.macAddres;
          mDeviceView.add(MDeviceView()..device = dv);
        }
      }
      inListDevice(mDeviceView);
    } catch (e) {
      showMessage(getErrorMessage(e.toString()));
      return Future.error(e);
    }
  }

  void deleteDeviceLocal(MDeviceView mDeviceView) async {
    try {
      final List<Device> localDevices = await getLocalDevices();
      localDevices.removeWhere((ld) => ld.macAddres == mDeviceView.device?.macAddres);
      rDeviceLocal.saveDevices(localDevices.toSet());
      await getAllDevices();
      showMessage('Se eliminó el dispositivo');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> saveDevices(MDeviceView mDeviceView) async {
    try {
      final Set<Device> listDeviceAux = {};
      for (var device in listDevice!) {
        if (device.device!.macAddres == mDeviceView.device!.macAddres ||
            device.save) {
          listDeviceAux.add(Device()
            ..name = device.device?.name
            ..distance = device.device?.distance
            ..macAddres = device.device?.macAddres);
        }
      }
      rDeviceLocal.saveDevices(listDeviceAux);
      await getAllDevices();
      showMessage('Se guardó el dispositivo');
    } catch (e) {
      //log(e.toString(), stackTrace: stackTrace);
      showMessage(getErrorMessage(e.toString()));
    }
  }

  @override
  void dispose() {
    _listDevice.close();
  }
}
