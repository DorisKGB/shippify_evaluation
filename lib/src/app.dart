import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc_application/b_application.dart';
import 'models/m_setting.dart';
import 'router/my_router.dart';
import 'utils/bloc_pattern/bloc_provider.dart';
import 'utils/style/app_color.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);  

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late BApplication bApplication;

  @override
  void initState() {
    bApplication = BlocProvider.of<BApplication>(context);
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<MSetting>(
      initialData: bApplication.bSettings.setting,
      stream: bApplication.bSettings.outSetting,
      builder: (context, snapshot) {
        return MaterialApp.router(
              restorationScopeId: 'app',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              /*supportedLocales: const [
                Locale('en', ''),
                Locale('es', ''),
              ],*/
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,          
            theme: ThemeData(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                colorScheme: ThemeData().colorScheme.copyWith(primary: AppColor.secundary),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: AppColor.secundary
                ),
                chipTheme: const ChipThemeData(
                  checkmarkColor: Colors.white,
                  selectedColor: AppColor.secundary,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                tabBarTheme: const TabBarTheme(
                  indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColor.secundary, width: 1.5)) 
                ),
                scaffoldBackgroundColor: Colors.white),
            darkTheme: ThemeData.dark(),
              themeMode: snapshot.data?.themeMode,
              routerDelegate: MyRouter.instance.router.routerDelegate,
              routeInformationParser: MyRouter.instance.router.routeInformationParser
            );
      }
    );
  }
}
