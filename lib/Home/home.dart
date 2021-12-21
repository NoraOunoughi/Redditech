import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:async';
import 'package:redditech_lucas_nora/TimeLine/viewsubs.dart';
import 'package:redditech_lucas_nora/UserProfile/profile.dart';
import 'package:redditech_lucas_nora/Settings/settings.dart';
import 'package:redditech_lucas_nora/Searches/search_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.lightBlue,),
                label: 'TimeLine',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,color: Colors.lightBlue,),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.child_care,color: Colors.lightBlue,),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,color: Colors.lightBlue,),
                label: 'Search',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
int _selectedIndex = 0;
const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
List<Widget> _widgetOptions = <Widget>[
  TimelinePage(),
  SettingsPage(),
  ProfilePage(),
  SearchPage(),
];