import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/services/point_history_provider.dart';
import 'package:biker_mice_from_mars/shared/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            appBar: AppBar(
              //toolbarHeight: 90,
              elevation: 1,
              backgroundColor: miceLightGreen,
              centerTitle: true,
              //automaticallyImplyLeading: false,
              title: Text("Your history",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ABeeZee',
                ),)
            ),
            backgroundColor: miceLightGreen,
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    for (PointHistory pointHistory in pointsHistoryList)
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: miceDarkGreen,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListTile(
                              focusColor: miceLightGreen,
                              leading: getTypeByName(pointHistory.transportationType),
                              subtitle: Text(
                                  '${pointHistory.transportationType} ${pointHistory.creationTime.substring(0, 10)} ${pointHistory.creationTime.substring(11, 19)}',
                                style: TextStyle(
                                  fontFamily: 'ABeeZee',
                                ),
                              ),
                              title: Text(
                                  'Points acquired: ${pointHistory.points}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'ABeeZee',
                                ),),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
Icon getTypeByName(String name){
  switch(name){
    case "bus": return Icon(Icons.directions_bus_rounded,color: Colors.black);
    case "train": return Icon(Icons.train,color: Colors.black);
    case "bike": return Icon(Icons.pedal_bike_rounded,color: Colors.black);
    case "tram":  return Icon(Icons.tram,color: Colors.black);
    case "metro":  return Icon(Icons.subway_outlined,color: Colors.black);
    case "food": return Icon(Icons.fastfood_rounded,color: Colors.black);
    case "clothes": return Icon(Icons.watch_outlined,color: Colors.black);
    default: return Icon(Icons.highlight_off,color: Colors.black);
  }
}

