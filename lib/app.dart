import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_integracao_api/routes/route_observer.dart';
import 'package:projeto_integracao_api/routes/routes.dart';
import 'package:projeto_integracao_api/shared/theme/app_theme.dart';

class App extends StatelessWidget {
  final MaterialColor colorSeed = Colors.indigo;

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Vistoria de Automóveis',
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      theme: ThemeApp(context: context).vistoriaTheme(),
      navigatorObservers: [HelperRoutes.routeObserver],
      routes: Routes.list,
      initialRoute: Routes.home ,
      navigatorKey: Routes.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
