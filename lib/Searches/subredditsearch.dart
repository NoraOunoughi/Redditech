// ignore_for_file: file_names

class SubredditSearch {
  final String? keyColor;
  final String? name;
  final String? title;
  final String? description;
  final int subscriberCount;
  final String? iconImg;
  final String? headerImg;
  final int activeUserCount;
  final bool isUserSubscribe;

  SubredditSearch({
    required this.keyColor,
    required this.name,
    required this.title,
    required this.description,
    required this.subscriberCount,
    required this.iconImg,
    required this.headerImg,
    required this.activeUserCount,
    required this.isUserSubscribe,
  });

  factory SubredditSearch.fromJsonSearch(dynamic subreddit) {
    return SubredditSearch(
        keyColor: subreddit['key_color'],
        name: subreddit['name'],
        title: "",
        description: "",
        subscriberCount: subreddit['subscriber_count'],
        iconImg: subreddit['icon_img'],
        headerImg: "",
        activeUserCount: 0,
        isUserSubscribe: false,
        
    );
  }

  factory SubredditSearch.fromJsonAbout(dynamic subreddit) {
    return SubredditSearch(
        keyColor: subreddit['primary_color'],
        name: subreddit['display_name'],
        title: subreddit['title'],
        description: subreddit['description'],
        subscriberCount: subreddit['subscribers'],
        iconImg: subreddit['icon_img'],
        headerImg: subreddit['header_img'],
        activeUserCount: subreddit['active_user_count'],
        isUserSubscribe: subreddit['user_is_subscriber'],
    );
  }
}