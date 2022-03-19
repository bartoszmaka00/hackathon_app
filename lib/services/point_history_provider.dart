import 'package:biker_mice_from_mars/models/point_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class PointHistoryProvider extends ChangeNotifier {
  PointHistoryProvider();
  List<PointHistory> _pointHistoryList = [];
  List<PointHistory> get pointHistoryList => _pointHistoryList;
  final String url = 'stark-harbor-12710.herokuapp.com';
  final String urlGetPoints = '/history_points';
  Future<List<PointHistory>> getPoints(String bearerToken) async {
    try {
      final response = await http.get(Uri.https(url, urlGetPoints),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        _pointHistoryList.clear();
        Map<String, dynamic> map = json.decode(response.body);
        List points = map['resources'];
        points.forEach(
            (point) => _pointHistoryList.add(PointHistory.fromJson(point)));
        notifyListeners();
        return _pointHistoryList;
      } else {
        notifyListeners();
        return _pointHistoryList;
      }
    } catch (e) {
      notifyListeners();
      return _pointHistoryList;
    }
  }
}
