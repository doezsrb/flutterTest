class User {
  User(
      {required this.id,
      required this.username,
      this.password,
      required this.token});
  int id;
  String username;
  String? password;
  String token;
}
