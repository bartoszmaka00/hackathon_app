import 'package:biker_mice_from_mars/models/station.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class StationProvider extends ChangeNotifier {
  StationProvider();

  Station _station = Station(
      startStation: 0,
      finishStation: 0,
      startTime: new DateTime(0),
      finishTime: new DateTime(0));

  Station get station => _station;
  final String url = 'stark-harbor-12710.herokuapp.com';
  final String stationGetUrl = '/travel_sessions.json';
  final String stationUpdateUrl = '/update_travel_sessions';
  final String stationDeleteUrl = '/delete_travel_sessions';

  Future<Station> getStationSession(String bearerToken) async {
    try {
      final response = await http.get(
        Uri.https(url, stationGetUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken,
        },
      );
      if (response.statusCode == 200) {
        _station = Station.fromJson(jsonDecode(response.body));
        notifyListeners();
        return station;
      } else {
        notifyListeners();
        return station;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return station;
    }
  }

  Future<bool> createStationSession(
      String bearerToken, int stationNumber) async {
    try {
      final response = await http.post(Uri.https(url, stationGetUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'travel_session': {'start_station': stationNumber}
          }));
      if (response.statusCode == 200) {
        _station = Station.fromJson(jsonDecode(response.body));
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return false;
    }
  }

  /// true means that update was successful
  Future<bool> updateStationSession(
      String bearerToken, int stationNumber) async {
    try {
      final response = await http.patch(Uri.https(url, stationUpdateUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'travel_session': {'end_station': stationNumber}
          }));
      if (response.statusCode == 200) {
        _station = Station(
            startTime: DateTime(0),
            finishTime: DateTime(0),
            startStation: -1,
            finishStation: -1);
        notifyListeners();
        return true;
      } else {
        print('Something failed');
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteStationSession(String bearerToken) async {
    try {
      final response = await http.delete(
        Uri.https(url, stationDeleteUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      if (response.statusCode == 200) {
        _station = Station(
            startTime: DateTime(0),
            finishTime: DateTime(0),
            startStation: -1,
            finishStation: -1);
        notifyListeners();
        return true;
      } else {
        print('Something failed');
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
