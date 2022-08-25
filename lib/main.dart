import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/utils/bloc_pattern/bloc_provider.dart';
import 'src/utils/service_locator.dart';

void main() async {
    runApp(
    BlocProvider(
      child: const MyApp(),
      blocBuilder: () => ServiceLocator.instance.bApplication()
    ),
  );
}
