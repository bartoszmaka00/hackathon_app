import 'package:biker_mice_from_mars/models/station.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:biker_mice_from_mars/services/authorization.dart';

class StationProvider extends ChangeNotifier {
  StationProvider();
  Station _station = Station(
      startStation: 0,
      finishStation: 0,
      startTime: new DateTime(0),
      finishTime: new DateTime(0),
      transportationType: "unknown");

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
      print('get ${response.statusCode}');
      if (response.statusCode == 200) {
        if (response.body != null) {
          _station = Station.fromJson(jsonDecode(response.body));
        }
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
      String bearerToken, int stationNumber, int type) async {
    try {
      final response = await http.post(Uri.https(url, stationGetUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'travel_session': {
              'start_station': stationNumber,
              'travel_tool': type
            }
          }));
      print('create ${response.statusCode}');
      if (response.statusCode == 201) {
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
      String bearerToken, int stationNumber, BuildContext context) async {
    try {
      final response = await http.patch(Uri.https(url, stationUpdateUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'travel_session': {'end_station': stationNumber}
          }));
      print('update ${response.statusCode}');
      if (response.statusCode == 200) {
        int points = (jsonDecode(response.body)['updated_points']);
        double carbon =
            double.parse((jsonDecode(response.body)['updated_carbon_saved']));
        var authorizationProvider =
            Provider.of<AuthorizationProvider>(context, listen: false);
        authorizationProvider.updatePoints(points, carbon);
        _station = Station(
            startTime: DateTime(0),
            finishTime: DateTime(0),
            startStation: 0,
            finishStation: 0,
            transportationType: "unknown");
        notifyListeners();
        return true;
      } else {
        print('Something failed update');
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
      print('delete ${response.statusCode}');
      if (response.statusCode == 200) {
        _station = Station(
            startTime: DateTime(0),
            finishTime: DateTime(0),
            startStation: 0,
            finishStation: 0,
            transportationType: "unknown");
        notifyListeners();
        return true;
      } else {
        print('Something failed delete');
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
