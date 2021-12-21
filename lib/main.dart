import 'package:flutter/material.dart';
import 'package:redditech_lucas_nora/UserProfile/user_preferences.dart';
import 'dart:async';
import 'package:redditech_lucas_nora/themes.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:redditech_lucas_nora/Login/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeProvider.of(context),
          home: LoginPage(),
        ),
      ),
    );
  }
}
