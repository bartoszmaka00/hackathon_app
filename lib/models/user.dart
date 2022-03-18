class User {
  final String bearerToken;
  String name;
  String lastName;
  String email;
  int points;
  final id;
  User(
      {required this.bearerToken,
      required this.name,
      required this.lastName,
      required this.email,
      required this.points,
      required this.id});
  factory User.fromJson(
      Map<String, dynamic> header, Map<String, dynamic> body) {
    return User(
        bearerToken: header['authorization'],
        name: body['name'],
        lastName: body['lastname'],
        email: body['email'],
        id: body['id'],
        points: body['points']);
  }
}
