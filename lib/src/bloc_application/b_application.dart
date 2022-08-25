import '../utils/bloc_pattern/bloc_base.dart';
import 'blocs/b_settings.dart';
import 'package:collection/collection.dart';

class BApplication extends BlocBase {
  final Set<BlocBase> _internalBlocs = {};

  BApplication(this.bSettings);

  late BSettings bSettings;


  @override
  void dispose() {
    bSettings.dispose();
  
  }

  T? getInternalBlocs<T extends BlocBase>() {
    return _internalBlocs.firstWhereOrNull((BlocBase element) => element is T)
        as T?;
  }

  void addInternalBloc(BlocBase bloc) {
    _internalBlocs.add(bloc);
  }

  void removeInternalBloc<T extends BlocBase>() {
    _internalBlocs.removeWhere((element) => element is T);
  }
}
