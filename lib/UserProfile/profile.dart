import 'package:flutter/material.dart';
import 'package:redditech_lucas_nora/Home/home.dart';
import 'package:redditech_lucas_nora/UserProfile/edit_profile.dart';
import 'package:redditech_lucas_nora/UserProfile/user_preferences.dart';
import 'package:redditech_lucas_nora/widget/profile_widget.dart';
import 'package:redditech_lucas_nora/UserProfile/user.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class ProfilePage  extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  User currentUser = UserPreferences.myUser;
  bool hasUser = false;
  void getMyUserInfos() async {
    currentUser = await getMeObject();
    UserPreferences.setUser(currentUser);
    hasUser = true;
    setState(() {});
  }
  @override
  void initState() {
    getMyUserInfos();
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
        if (hasUser == false) {
          return Container();
        }
        return ThemeSwitchingArea(
          child: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(leading: IconButton(
                  icon: Icon(Icons.child_care),
                  onPressed: () {}),
                backgroundColor: Colors.blue,
              title: Text("My Profile"),),

              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileWidget(
                      imageProfile: currentUser.imageProfile,
                      onClicked: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditProfile())
                        );
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    buildName(currentUser),
                    const SizedBox(height: 48),
                    buildDescription(currentUser),
                  ],
                ),
              ),
            ),
          ),
        );
    }

    Widget buildName(User user) => Column(
          children: [
            Text(
              user.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        );
    
    Widget buildDescription(User user) => Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                user.description,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        );
}