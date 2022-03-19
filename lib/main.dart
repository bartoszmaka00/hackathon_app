import 'package:biker_mice_from_mars/shared/constans.dart';
import 'package:biker_mice_from_mars/services/point_history_provider.dart';
import 'package:biker_mice_from_mars/views/menu.dart';
import 'package:biker_mice_from_mars/views/points_history.dart';
import 'package:biker_mice_from_mars/views/privileges.dart';

import 'package:flutter/material.dart';
import 'shared/routes.dart';
import 'package:provider/provider.dart';
import 'services/authorization.dart';
import 'services/station_provider.dart';
import 'services/privileges_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthorizationProvider()),
        ChangeNotifierProvider(create: (context) => PointHistoryProvider()),
        ChangeNotifierProvider(create: (context) => StationProvider()),
        ChangeNotifierProvider(create: (context) => PrivilegesProvider())
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: MaterialApp(
          routes: myRoutes,
          title: 'CarbonLess',
          initialRoute: '/',
          theme: ThemeData(
            primarySwatch: Palette.miceButtonColor,
          ),
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [Menu(), PointsHistory(), Privileges()];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.bus_alert),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.wallet_giftcard),
            label: 'My Priveleges',
          )
        ],
      ),
    );
  }
}
