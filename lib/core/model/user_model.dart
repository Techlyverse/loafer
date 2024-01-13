class UserModel {
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.isOnline,
    this.userColor,
  });

  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final bool isOnline;
  final UserColor? userColor;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      isOnline: json['isOnline'],
      userColor: UserColor.fromJson(json['userColor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "isOnline": isOnline,
      "userColor": userColor?.toJson(),
    };
  }
}

class UserColor {
  const UserColor({
    this.isDarkMode,
    this.primary,
    this.onPrimary,
    this.primaryContainer,
    this.onPrimaryContainer,
  });

  final bool? isDarkMode;
  final int? primary;
  final int? onPrimary;
  final int? primaryContainer;
  final int? onPrimaryContainer;

  factory UserColor.fromJson(Map<String, dynamic> json) {
    return UserColor(
      isDarkMode: json['isDarkMode'],
      primary: json['primary'],
      onPrimary: json['onPrimary'],
      primaryContainer: json['primaryContainer'],
      onPrimaryContainer: json['onPrimaryContainer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isDarkMode": isDarkMode,
      "primary": primary,
      "onPrimary": onPrimary,
      "primaryContainer": primaryContainer,
      "onPrimaryContainer": onPrimaryContainer,
    };
  }
}
