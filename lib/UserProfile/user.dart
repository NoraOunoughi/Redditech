
class User {
  final String imageProfile;
  final String username;
  final String description;
  final bool isDarkMode;

  const User({
    required this.imageProfile,
    required this.username,
    required this.description,
    required this.isDarkMode,
  });
  String getDescription() {
    return this.description;
  }

  User copy({
    String? imageProfile,
    String? username,
    String? description,
    bool? isDarkMode,
  }) =>
      User(
        imageProfile: imageProfile ?? this.imageProfile,
        username: username ?? this.username,
        description: description ?? this.description,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        username: json['name'],
        description: json['subreddit']['public_description'],
        imageProfile: json['icon_img'],
        isDarkMode: json['isDarkMode'],
      );
  Map<String, dynamic> toJson() => {
        'imageProfile': imageProfile,
        'username': username,
        'description': description,
        'isDarkMode': isDarkMode,
  };
}