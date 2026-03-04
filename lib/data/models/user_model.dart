class UserModel {
  final int id;
  final String username;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}