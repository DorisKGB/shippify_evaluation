import 'package:shippify_evaluation/application/repositories/r_device_local.dart';
import 'package:shippify_evaluation/infraestructure/local/r_device_local_imp.dart';

import '../bloc_application/b_application.dart';
import '../bloc_application/blocs/b_settings.dart';
import '../pages/device/bloc/b_device.dart';

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._internal();

  ServiceLocator._internal();

  //Repositories
  RDeviceLocal get rDeviceLocal => RDeviceLocalImp();

  //Blocs
  BApplication bApplication() => BApplication(bSettings());
  BSettings bSettings() => BSettings();
  BDevice bDevice() => BDevice(rDeviceLocal);
}
