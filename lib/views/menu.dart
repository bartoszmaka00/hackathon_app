import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/services/station_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isVisibleLoading = false;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<Null> _load() async {
    setState(() {
      isVisibleLoading = true;
    });
    await Provider.of<StationProvider>(context, listen: false)
        .getStationSession(
            Provider.of<AuthorizationProvider>(context, listen: false)
                .user
                .bearerToken);
    setState(() {
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var authorizationProvider =
        Provider.of<AuthorizationProvider>(context, listen: false);
    int points = authorizationProvider.user.points;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You\'ve got $points points!'),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/history'),
                      child: Text('History')),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/qr_test'),
                    child: Text('Scan QR Code'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/privileges'),
                      child: Text('My privileges'))
                ],
              ),
            ),
          );
  }
}
