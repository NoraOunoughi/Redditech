import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redditech_lucas_nora/widget/profile_widget.dart';
import 'package:redditech_lucas_nora/widget/button_widget.dart';
import 'package:redditech_lucas_nora/widget/textfield_widget.dart';
import 'package:redditech_lucas_nora/UserProfile/user_preferences.dart';
import 'package:redditech_lucas_nora/UserProfile/user.dart';
import 'package:path/path.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User currentUser;
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
        builder: (context) =>
            Scaffold(
              appBar: AppBar(
                leading: Icon(Icons.edit),
                backgroundColor: Colors.blue,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileWidget(
                      imageProfile: currentUser.imageProfile,
                      isEdit: true,
                      onClicked: () async {
                        final image = await ImagePicker().getImage(
                            source: ImageSource.gallery);
                        if (image == null) return;

                        final directory = await getApplicationDocumentsDirectory();
                        final name = basename(image.path);
                        final imageFile = File('${directory.path}/$name');
                        final newImage =
                          await File(image.path).copy(imageFile.path);
                        setState(() => currentUser = currentUser.copy(imageProfile: newImage.path));
                        //dans fonction setState, ajouter le call API pour modifier les valeurs à travers la request
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Username',
                        text: currentUser.username,
                        onChanged: (username) => currentUser = currentUser.copy(username: username),
                        //dans fonction onChanged, ajouter le call API pour modifier les valeurs à travers la request
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Description',
                        text: currentUser.description,
                        maxLines: 5,
                        onChanged: (description) => currentUser = currentUser.copy(description: description),
                        //dans fonction onChanged, ajouter le call API pour modifier les valeurs à travers la request
                    ),
                    const SizedBox(height: 24),
                    ButtonWidget(
                      text: 'Save',
                      onClicked: () {
                        UserPreferences.setUser(currentUser);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
