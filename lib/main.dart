import 'package:E_commerce/pages/home.dart';
import 'package:E_commerce/providers/card_provider.dart';
import 'package:E_commerce/providers/favorite_provider.dart';
import 'package:E_commerce/providers/ordered_provider.dart';
import 'package:E_commerce/providers/settings_provider.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:E_commerce/providers/modal_hud.dart';
import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:E_commerce/pages/splash_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool valueOfLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          } else {
            valueOfLoggedIn =
                snapshot.data.getBool(KEEP_USER_LOGGED_IN_KEY) ?? false;
            return MultiProvider(
              providers: providers,
              child: Builder(builder: (context) {
                var darkProvider = Provider.of<SettingsProvider>(context);
                return MaterialApp(
                  supportedLocales: [
                    const Locale('en'), // English
                    const Locale('ar'), // Hebrew
                  ],
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocale) {
                    for (var locale in supportedLocale) {
                      if (locale.languageCode == deviceLocale.languageCode) {
                        return deviceLocale;
                      }
                    }
                    return supportedLocale.first;
                  },
                  title: 'GemyStore',
                  theme: ThemeData(
                    brightness: darkProvider.darkModeSelected
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  initialRoute: valueOfLoggedIn == true ? "home" : "splash",
                  routes: {
                    "home": (context) => Home(),
                    "splash": (context) => SplashScreen()
                  },
                  debugShowCheckedModeBanner: false,
                );
              }),
            );
          }
        });
  }

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<ModalProgress>(create: (context) => ModalProgress(),),
    ChangeNotifierProvider<CartDate>(create: (context) => CartDate()),
    ChangeNotifierProvider<SettingsProvider>(create: (context) => SettingsProvider()),
    ChangeNotifierProvider<CardProvider>(create: (context) => CardProvider()),
    ChangeNotifierProvider<FavoriteData>(create: (context) => FavoriteData()),
    ChangeNotifierProvider<OrderedData>(create: (context) => OrderedData()),
  ];
}
