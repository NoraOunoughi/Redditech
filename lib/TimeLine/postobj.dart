class myRedditPost {
  final String? author;
  final String? subreddit;
  final String? title;
  final String? selftext;
  final int ups;
  final int downs;
  final int score;
  final String? thumbnail;

  myRedditPost({
    required this.author,
    required this.subreddit,
    required this.title,
    required this.selftext,
    required this.ups,
    required this.downs,
    required this.score,
    required this.thumbnail,
  });

  factory myRedditPost.fromJson(dynamic post) {
    return myRedditPost(
        author: post['data']['author'],
        subreddit: post['data']['subreddit'],
        title: post['data']['title'],
        selftext: post['data']['selftext'],
        ups: post['data']['ups'],
        downs: post['data']['downs'],
        score: post['data']['score'],
        thumbnail: post['data']['thumbnail']
    );
  }
}

class HandleListing {
  final String? start;
  final String? end;
  final int count;

  HandleListing({
    required this.start,
    required this.end,
    required this.count,
  });
}

class ListingPost {
  final String? start;
  final String? end;
  final int count;
  final List<myRedditPost> allPosts;

  ListingPost({
    required this.start,
    required this.end,
    required this.allPosts,
    required this.count,
  });
}