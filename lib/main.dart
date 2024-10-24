import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_integracao_api/shared/global_providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';

String AppVersion = 'DESCONHECIDO';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  getVersionInfo();

  timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
  timeago.setDefaultLocale('pt_br');
  Intl.defaultLocale = 'pt_BR';
  runApp(
    MultiProvider(
      providers: providers,
      child: const App(),
    ),
  );
}

void getVersionInfo() {
  AppVersion = '0.1';
}
