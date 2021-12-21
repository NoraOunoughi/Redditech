import 'package:flutter/material.dart';
import 'package:redditech_lucas_nora/TimeLine/postobj.dart';


Widget mycardPost(myRedditPost post) {
  return Container(
    child: Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          post.author == null ? Container() : Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "@" + post.author.toString(),
                style: const TextStyle(
                    color: Color(0xff003be7),
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
          ),
          post.subreddit == null ? Container() : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "/" + post.subreddit.toString(),
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 23),
              ),
            ),
          ),
          post.title == null ? Container() :
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                post.title.toString(),
                style: const TextStyle(
                    color: Color(0xff4da4ff),
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
          ),
          post.selftext == null ? Container() :
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                post.selftext.toString(),
                style: const TextStyle(
                    color: Color(0xff0c0101),
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
            ),
          ),
          post.thumbnail != null && post.thumbnail.toString() != "default" && post.thumbnail.toString() != "self" && post.thumbnail.toString() != "" && post.thumbnail.toString() != "image" ?
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(post.thumbnail.toString()), fit: BoxFit.contain)),
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    ),
  );
}