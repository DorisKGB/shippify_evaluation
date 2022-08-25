import '../bloc_application/b_application.dart';
import '../bloc_application/blocs/b_settings.dart';
import '../pages/device/bloc/b_device.dart';

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._internal();

  ServiceLocator._internal();



  //Repositories

  //Services

  //Blocs
  BApplication bApplication() => BApplication(bSettings());
  BSettings bSettings() => BSettings();
  BDevice bSignUp() => BDevice();
}
