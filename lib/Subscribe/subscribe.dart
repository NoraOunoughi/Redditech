import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redditech_lucas_nora/Searches/subredditsearch.dart';
import 'dart:convert' show jsonDecode;
import 'dart:convert' as convert;
import 'package:redditech_lucas_nora/TimeLine/postobj.dart';
import 'package:redditech_lucas_nora/TimeLine/thread.dart';

subtosubreddit(String name) async {
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  String url = "https://oauth.reddit.com/api/subscribe?action=sub;sr_name=" + name;

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );
}

unsubtosubreddit(String name) async {
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  String url = "https://oauth.reddit.com/api/subscribe?action=unsub;sr_name=" + name;

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );
}
