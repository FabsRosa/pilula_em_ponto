import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:pilula_em_ponto/constants/env.dart';
import 'package:pilula_em_ponto/screens/screen_controller.dart';
import 'package:pilula_em_ponto/themes/main_theme.dart';

void main() async {
  // Load .env file
  await Env.init();

  // Load locales
  initializeDateFormatting().then(
    (_) => runApp(
      // Load Riverpod Provider
      ProviderScope(
        child:
            // Run App
            const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dupli NFC',
      theme: MainTheme.darkTheme,
      home: ScreenController(),
    );
  }
}
