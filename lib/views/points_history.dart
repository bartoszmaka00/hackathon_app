import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/services/point_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biker_mice_from_mars/services/point_history_provider.dart';
import 'package:biker_mice_from_mars/views/loading_screen.dart';

import '../models/point_history.dart';

class PointsHistory extends StatefulWidget {
  const PointsHistory({Key? key}) : super(key: key);

  @override
  State<PointsHistory> createState() => _PointsHistoryState();
}

class _PointsHistoryState extends State<PointsHistory> {
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
    await Provider.of<PointHistoryProvider>(context, listen: false).getPoints(
        Provider.of<AuthorizationProvider>(context, listen: false)
            .user
            .bearerToken);
    setState(() {
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var pointsHistoryProvider =
        Provider.of<PointHistoryProvider>(context, listen: false);
    List<PointHistory> pointsHistoryList =
        pointsHistoryProvider.pointHistoryList;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text('Your history:'),
                  Container(
                    width: 400,
                    height: 400,
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      padding: EdgeInsets.all(10),
                      children: [
                        for (PointHistory pointHistory in pointsHistoryList)
                          Column(
                            children: [
                              Text('Points acquired: ${pointHistory.points}'),
                              SizedBox(height: 2),
                              Text('Acquired at: ${pointHistory.creationTime}')
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
