import 'package:biker_mice_from_mars/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum Status {
  uninitialized,
  unauthorized,
  authorized,
}

class AuthorizationProvider extends ChangeNotifier {
  AuthorizationProvider();

  User _user = User(
      bearerToken: '', name: '', lastName: '', email: '', points: 0, id: -1);
  User get user => _user;
  Status _isAuthorized = Status.uninitialized;
  Status get isAuthorized => _isAuthorized;
  final String url = 'stark-harbor-12710.herokuapp.com';
  final String urlSignIn = '/users/sign_in.json';
  final String urlSignUp = '/users.json';
  Future<User> loginUser(String email, String password) async {
    try {
      final response = await http.post(Uri.https(url, urlSignIn),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'password': password,
            }
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        _user = User.fromJson(response.headers, jsonDecode(response.body));
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      } else {
        _isAuthorized = Status.unauthorized;
        notifyListeners();
        return user;
      }
    } catch (e) {
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return user;
    }
  }

  Future<User> registerUser(String email, String password,
      String passwordConfirmation, String name, String lastName) async {
    try {
      final response = await http.post(Uri.https(url, urlSignUp),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'name': name,
              'lastname': lastName,
              'password': password,
              'password_confirmation': passwordConfirmation
            }
          }));
      if (response.statusCode == 201) {
        _user = User.fromJson(response.headers, jsonDecode(response.body));
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      } else {
        _isAuthorized = Status.unauthorized;
        notifyListeners();
        return user;
      }
    } catch (e) {
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return user;
    }
  }
}
