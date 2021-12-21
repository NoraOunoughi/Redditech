import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redditech_lucas_nora/Searches/subredditsearch.dart';
import 'package:redditech_lucas_nora/Searches/subredditresults.dart';

Widget mycardSubSearch(BuildContext context, SubredditSearch post) {
  return Container(
    child : ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: post.iconImg != null ? NetworkImage(post.iconImg.toString()) : null,
      ),
      title: post.name == null ? null : Text("/" + post.name.toString()),
      subtitle: post.subscriberCount == null ? null : Text(post.subscriberCount.toString() + " members"),
      enabled: true,
      onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchResultsPage(post.name.toString()))
          );
        },
      ),
  );
}