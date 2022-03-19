import 'dart:convert';
import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:biker_mice_from_mars/models/user_privilege.dart';

class UserPrivilegesProvider extends ChangeNotifier {
  UserPrivilegesProvider();
  List<UserPrivilege> _userPrivileges = [];
  List<UserPrivilege> get userPrivileges => _userPrivileges;
  final String url = 'stark-harbor-12710.herokuapp.com';
  final String urlUserGetPrivileges = '/users_prizes';
  final String urlUserPurchasePrivileges = '/users_prizes';
  Future<List<UserPrivilege>> getUserPrivileges(String bearerToken) async {
    try {
      final response = await http.get(Uri.https(url, urlUserGetPrivileges),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          });
      print('user privileges provider ${response.statusCode}');
      if (response.statusCode == 200) {
        _userPrivileges.clear();
        Map<String, dynamic> map = json.decode(response.body);
        List privileges = map['resources'];
        privileges.forEach((privilege) =>
            _userPrivileges.add(UserPrivilege.fromJson(privilege)));
        notifyListeners();
        return _userPrivileges;
      } else {
        notifyListeners();
        return _userPrivileges;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return _userPrivileges;
    }
  }

  Future<bool> purchasePrivilege(
      String bearerToken, int id, int duration) async {
    try {
      final response = await http.post(
          Uri.https(url, urlUserPurchasePrivileges),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'user_prize': {'prize_id': id, 'duration_left': duration},
          }));
      print('user privilege purchase ${response.statusCode}');
      if (response.statusCode == 200) {
        getUserPrivileges(bearerToken);
        notifyListeners();
        return true;
      } else {
        print('nie dostalem 200 purchase');
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return false;
    }
  }
}
