import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'dart:convert' as convert;
import 'package:redditech_lucas_nora/Searches/subredditsearch.dart';

Future<List<SubredditSearch>> getSubredditWithNameSearch(String name) async {
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  String url = "https://oauth.reddit.com/api/search_subreddits";
  List<SubredditSearch> allSearched = [];

  url = url + "?query=" + name + ";raw_json=1";
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );

  Map<dynamic, dynamic>? json = jsonDecode(response.body);
  if (json != null && json['subreddits'] != null) {
    for (var searched in json['subreddits']) {

      String? keyColor = searched['key_color'];
      String? name = searched['name'];
      int subscriberCount = searched['subscriber_count'];
      String iconImg = searched['icon_img'];

      SubredditSearch subSearched = SubredditSearch.fromJsonSearch(searched);
      allSearched.add(subSearched);
    }
  }
  return allSearched;
}

Future<SubredditSearch>getSubredditWithName(String name) async {
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  String url = "https://oauth.reddit.com/r/" + name + "/about?raw_json=1";
  SubredditSearch searched = SubredditSearch(
      keyColor: "",
      name: "",
      title: "",
      description: "",
      subscriberCount: 0,
      iconImg: "",
      headerImg: "",
      activeUserCount: 0,
      isUserSubscribe: false,
  );
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );

  Map<dynamic, dynamic>? json = jsonDecode(response.body);
  if (json != null && json['data'] != null) {

    String? primarycolor = json['data']['primary_color'];
    print(primarycolor);
    String? displayname = json['data']['display_name'];
    print(displayname);
    String? title = json['data']['title'];
    print(title);
    String? description = json['data']['description'];
    int subscribers = json['data']['subscribers'];
    print(subscribers);
    String? iconImg = json['data']['icon_img'];
    print(iconImg);
    String? headerImg = json['data']['header_img'];
    print(headerImg);
    int activeUserCount = json['data']['active_user_count'];
    print(activeUserCount);

    searched = SubredditSearch.fromJsonAbout(json['data']);
  }
  return searched;
}

Future<String> getMeJson() async {
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  String url = "https://oauth.reddit.com/api/me.json?raw_json=1";
  SubredditSearch searched;

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );

  Map<dynamic, dynamic>? json = jsonDecode(response.body);
  if (json != null && json['data'] != null) {
    String? modhash = json['data']['modhash'];
  }
  String res = "";
  return res;
}