import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'dart:convert' as convert;
import 'package:redditech_lucas_nora/TimeLine/postobj.dart';

Future<ListingPost> getPosts(String subreddit, String sortParam, HandleListing listingParameter) async {
  int nbLimitePost = 10;
  ListingPost post;
  var dist = 0;
  String? start;
  String? end;
  String startParam = listingParameter.end != null ? listingParameter.end.toString() : "";
  String endParam = listingParameter.start != null ? listingParameter.start.toString() : "";
  String url = "https://oauth.reddit.com";
  const _storage = FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");

  if (subreddit != "") {
    url = url + "/r/" + subreddit;
  }
  if (sortParam != "") {
    url = url + "/" + sortParam;
  }
  if (startParam != "") {
    url = url + "?before=" + startParam + "&limit=" + nbLimitePost.toString() + "&count=" + listingParameter.count.toString() +"&raw_json=1";
  } else if (endParam != "") {
    url = url + "?after=" + endParam + "&limit=" + nbLimitePost.toString() + "&count=" + listingParameter.count.toString() +"&raw_json=1";
  } else {
    url = url + "?limit=" + nbLimitePost.toString() + "&raw_json=1";
  }
  List<myRedditPost> listmyRedditPosts = [];
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );

  Map<dynamic, dynamic>? json = jsonDecode(response.body);
  if (json != null && json['data'] != null) {
    start = json['data']['before'];
    end = json['data']['after'];
    dist = int.parse(json['data']['dist'].toString());

    for (var post in json['data']['children']) {
      myRedditPost myPostObject = myRedditPost.fromJson(post);
      listmyRedditPosts.add(myPostObject);
    }
  }
  var total = listingParameter.count + dist;
  post = ListingPost(start: start, end: end, allPosts: listmyRedditPosts, count: total);
  return post;
}