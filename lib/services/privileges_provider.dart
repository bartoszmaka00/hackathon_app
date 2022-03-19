import 'package:biker_mice_from_mars/models/privilege.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class PrivilegesProvider extends ChangeNotifier {
  PrivilegesProvider();
  List<Privilege> _privileges = [];
  List<Privilege> get privileges => _privileges;
  final String url = 'stark-harbor-12710.herokuapp.com';
  final String urlGetPrivileges = '/prizes.json?page=1';

  Future<List<Privilege>> getPrivileges(String bearerToken) async {
    try {
      final response = await http.get(Uri.https(url, urlGetPrivileges),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          });
      print('privileges provider ${response.statusCode}');
      if (response.statusCode == 200) {
        _privileges.clear();
        Map<String, dynamic> map = json.decode(response.body);
        List privileges = map['resources'];
        privileges.forEach(
            (privilege) => _privileges.add(Privilege.fromJson(privilege)));
        notifyListeners();
        return _privileges;
      } else {
        notifyListeners();
        return _privileges;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return _privileges;
    }
  }
}
