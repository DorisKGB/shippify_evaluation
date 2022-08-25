import 'package:go_router/go_router.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import '../../../core/catalog/enum/c_errors.dart';
import '../../router/my_router.dart';
import '../mixin/action_view_screen.dart';
//import '../service_locator.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

abstract class BlocBase with ActionView {
  void dispose();
  GoRouter get navigator => MyRouter.instance.router;
  String getErrorMessage(String error){
    return error.toString();
  }
}
