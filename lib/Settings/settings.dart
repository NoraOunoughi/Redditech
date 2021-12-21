import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:redditech_lucas_nora/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redditech_lucas_nora/UserProfile/user.dart';
import 'package:redditech_lucas_nora/UserProfile/user_preferences.dart';
import 'package:redditech_lucas_nora/Login/login.dart';
import 'package:redditech_lucas_nora/widget/icon_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redditech_lucas_nora/Auth/myweb.dart';
import 'dart:convert' show jsonDecode;
import 'dart:convert' show jsonEncode;


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = UserPreferences.getUser();
  static const keyLang = 'key-lang';
  static const keyDark = 'key-dark';
  static const keyPm = 'key-messages';
  static const keyCountry = 'key-country';
  static const keyComments = 'key-comments';
  static const key18 = 'key-18';
  static var over18 = false;

  Future<dynamic> getUserSettingByName(String name) async {
    final _storage = new FlutterSecureStorage();
    final myaccesstoken = await _storage.read(key: "myaccesstoken");
    http.Response response = await http.get(
      Uri.parse("https://oauth.reddit.com/api/v1/me/prefs?fields=" + name),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "bearer $myaccesstoken",
      },
    );
    dynamic res = jsonDecode(response.body)[name];
    return res;
  }

  setUserSettingsByName(String name, String value) async {
    final _storage = new FlutterSecureStorage();
    final myaccesstoken = await _storage.read(key: "myaccesstoken");
    http.Response response = await http.patch(
      Uri.parse("https://oauth.reddit.com/api/v1/me/prefs"),
      body: jsonEncode({
        name: value,
      }),
      headers: {
        "Authorization": "bearer $myaccesstoken",
      },
    );
    print("RESPONSE ${response.statusCode}");
  }

  void getMyUserInfos() async {
    over18 = await getUserSettingByName("over_18");
    print(over18);
    over18 = await getUserSettingByName("over_18");
    print(over18);
    setState(() {});
  }

  @override
  void initState() {
    getMyUserInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(backgroundColor: Colors.blue,
              leading: Icon(Icons.settings),
              title: Text("Settings"),),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.all(24),
                children: [
                  SettingsGroup(
                    title: 'GENERAL',
                    children: <Widget>[
                      buildLang(),
                      const SizedBox(height: 24,),
                      buildCountry(),
                      const SizedBox(height: 24,),
                      buildPrivateMsg(),
                      const SizedBox(height: 24,),
                      buildBadComments(),
                      const SizedBox(height: 24,),
                      buildNsfw(),
                      const SizedBox(height: 24,),
                      buildDarkMod(),
                      const SizedBox(height: 24,),
                      buildLogout(),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  
  Widget buildCountry() =>
      DropDownSettingsTile(
        title: 'Country Account',
        settingKey: keyCountry,
        selected: 1,
        values: <int, String>{
          1: 'France',
          2: 'England',
          3: 'Portugal',
          4: 'Spain'
        },
        onChange: (country) async {
          if (country == 1)
          await setUserSettingsByName('country_code', 'FR');
          if (country == 2)
            await setUserSettingsByName('country_code', 'GB');
          if (country == 3)
            await setUserSettingsByName('country_code', 'PT');
          if (country == 4)
            await setUserSettingsByName('country_code', 'ES');
        },
      );

  Widget buildLang() =>
      DropDownSettingsTile(
        title: 'Language',
        settingKey: keyLang,
        selected: 1,
        values: <int, String>{
          1: 'Français',
          2: 'English',
          3: 'Português',
          4: 'Espanol'
        },
        onChange: (lang) async {
          var test = await getUserSettingByName("lang");
          if (lang == 1)
            await setUserSettingsByName('lang', 'fr');
          if (lang == 2)
            await setUserSettingsByName('lang', 'en');
          if (lang == 3)
            await setUserSettingsByName('lang', 'pt');
          if (lang == 4)
            await setUserSettingsByName('lang', 'es');
          test = await getUserSettingByName("lang");
        },
      );

  Widget buildPrivateMsg() =>
      DropDownSettingsTile(
        title: 'Accept private messages',
        settingKey: keyPm,
        selected: 1,
        values: <int, String>{
          1: 'From everyone',
          2: 'From whitelisted people',
        },
        onChange: (pm) async {
          if (pm == 1)
            await setUserSettingsByName('accept_pms', 'everyone');
          if (pm == 2)
            await setUserSettingsByName('accept_pms', 'whitelisted');
        },
      );

  Widget buildDarkMod() =>
      DropDownSettingsTile(
        title: 'Night mod',
        settingKey: keyDark,
        selected: 1,
        values: <int, String>{
          1: 'Light',
          2: 'Dark',
        },
        onChange: (dark) async {
          if (dark == 1) {
            UserPreferences.setUser(User(
              imageProfile: '',
              username : '',
              description: '',
              isDarkMode: false,
            ));
            final theme = MyThemes.lightTheme;
            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
            await setUserSettingsByName('nightmode', 'false');
          }
          if (dark == 2) {
            UserPreferences.setUser(User(
                imageProfile: '',
                username : '',
                description: '',
                isDarkMode: true,
            ));
            final theme = MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
            await setUserSettingsByName('nightmode', 'true');
          }
        },
      );

  Widget buildNsfw() =>
      DropDownSettingsTile(
        title: 'Adult content',
        settingKey: key18,
        selected: 1,
        values: <int, String>{
          1: 'Enabled',
          2: 'Disabled',
        },
        onChange: (nsfw) async {
          if (nsfw == 1)
            await setUserSettingsByName('over_18', 'true');
          if (nsfw == 2)
            await setUserSettingsByName('over_18', 'false');
        },
      );

  Widget buildBadComments() =>
      DropDownSettingsTile(
        title: 'Bad comments filter',
        settingKey: keyComments,
        selected: 1,
        values: <int, String>{
          1: 'Off',
          2: 'Low',
          3: 'Medium',
          4: 'High',
        },
        onChange: (comments) async {
          if (comments == 1)
            await setUserSettingsByName('bad_comment_autocollapse', 'off');
          if (comments == 2)
            await setUserSettingsByName('bad_comment_autocollapse', 'low');
          if (comments == 3)
            await setUserSettingsByName('bad_comment_autocollapse', 'medium');
          if (comments == 4)
            await setUserSettingsByName('bad_comment_autocollapse', 'high');
        },
      );
      
  Widget buildLogout() =>
      SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: const IconWidget(icon: Icons.logout, color: Colors.blueAccent),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  LoginPage())),
      );
}