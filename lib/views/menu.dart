import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/services/station_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/constans.dart';

import 'loading_screen.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isVisibleLoading = false;
  int points = 0;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<Null> _load() async {
    // int points;
    setState(() {
      isVisibleLoading = true;
    });
    await Provider.of<StationProvider>(context, listen: false)
        .getStationSession(
            Provider.of<AuthorizationProvider>(context, listen: false)
                .user
                .bearerToken);
    setState(() {
      points = Provider.of<AuthorizationProvider>(context, listen: false)
          .user
          .points;
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var authorizationProvider =
        Provider.of<AuthorizationProvider>(context, listen: false);
    var stationProvider = Provider.of<StationProvider>(context, listen: false);
    // stationProvider.station.startStation == 0
    // int points = authorizationProvider.user.points;
    bool isVisibleExit =
        stationProvider.station.startStation == 0 ? false : true;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: miceLightGreen,
            appBar: AppBar(
              toolbarHeight: 90,
              elevation: 1,
              backgroundColor: miceLightGreen,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Image(
                image: AssetImage('assets/logo.png'),
                width: 110,
                height: 110,
              ),
            ),
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: micemiddleGreen,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45,
                              ),
                              Text(
                                'Carbon saved:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABeeZee',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${authorizationProvider.user.carbonFootprint} kg',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ABeeZee',
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: micemiddleGreen,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45,
                              ),
                              Text(
                                'Points:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABeeZee',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '$points',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABeeZee',
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text('Session time : '+ now.difference(stationProvider.station.startTime!).inMinutes.toString()),
                        // Text('Session time : '+ (DateTime.now().difference(DateTime(2022, 3, 19)).inMinutes/60).floor().toString() + ' ' +(DateTime.now().difference(DateTime(2022, 3, 19)).inSeconds/3600).floor().toString()
                        // ),
                        // LinearProgressIndicator(
                        //   backgroundColor: miceLightGreen,
                        //   color: miceDarkGreen,
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        SizedBox(
                          width: !isVisibleExit
                              ? mainMenuButonWidth
                              : mainMenuButonWidthSmall,
                          height: !isVisibleExit
                              ? mainMenuButonHeight
                              : mainMenuButonHeightSmall,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: micemiddleGreen,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/qr_test'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.directions_bus_rounded,
                                  color: Colors.white,
                                  size: !isVisibleExit
                                      ? mainMenuButtonFontSize + 10
                                      : mainMenuButtonFontSizeSmall + 10,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  isVisibleExit
                                      ? 'Finish a ride'
                                      : 'Start a ride',
                                  style: TextStyle(
                                    fontSize: !isVisibleExit
                                        ? mainMenuButtonFontSize
                                        : mainMenuButtonFontSizeSmall,
                                    color: Colors.white,
                                    fontFamily: 'ABeeZee',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: !isVisibleExit
                              ? mainMenuButonWidth
                              : mainMenuButonWidthSmall,
                          height: !isVisibleExit
                              ? mainMenuButonHeight
                              : mainMenuButonHeightSmall,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: micemiddleGreen,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/qr_purchase'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.discount,
                                  color: Colors.white,
                                  size: !isVisibleExit
                                      ? mainMenuButtonFontSize + 10
                                      : mainMenuButtonFontSizeSmall + 10,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Eco - Purchase',
                                  style: TextStyle(
                                    fontSize: !isVisibleExit
                                        ? mainMenuButtonFontSize
                                        : mainMenuButtonFontSizeSmall,
                                    color: Colors.white,
                                    fontFamily: 'ABeeZee',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: !isVisibleExit
                                  ? mainMenuButonWidth / 2.25
                                  : mainMenuButonWidthSmall / 2.25,
                              height: !isVisibleExit
                                  ? mainMenuButonHeight
                                  : mainMenuButonHeightSmall,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: micemiddleGreen,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/history'),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.article_outlined,
                                        color: Colors.white,
                                        size: !isVisibleExit
                                            ? mainMenuButtonFontSize
                                            : mainMenuButtonFontSize,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        ' History',
                                        style: TextStyle(
                                          fontSize: !isVisibleExit
                                              ? mainMenuButtonFontSize - 8
                                              : mainMenuButtonFontSize - 8,
                                          color: Colors.white,
                                          fontFamily: 'ABeeZee',
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: !isVisibleExit
                                  ? mainMenuButonWidth / 2.25
                                  : mainMenuButonWidthSmall / 2.25,
                              height: !isVisibleExit
                                  ? mainMenuButonHeight
                                  : mainMenuButonHeightSmall,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: micemiddleGreen,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pushNamed(
                                          context, '/privileges')
                                      .then((_) => setState(() {
                                            points = authorizationProvider
                                                .getUpdatedPoints();
                                          })),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.wallet_giftcard,
                                        color: Colors.white,
                                        size: !isVisibleExit
                                            ? mainMenuButtonFontSize
                                            : mainMenuButtonFontSize,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        ' Benefits',
                                        style: TextStyle(
                                          fontSize: !isVisibleExit
                                              ? mainMenuButtonFontSize - 8
                                              : mainMenuButtonFontSize - 8,
                                          fontFamily: 'ABeeZee',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: !isVisibleExit ? 0 : 15),
                        Visibility(
                          visible: isVisibleExit,
                          child: SizedBox(
                              width: mainMenuButonWidthSmall,
                              height: mainMenuButonHeightSmall,
                              child: Column(
                                children: [
                                  // Text('You have already started a ride.'),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: micemiddleGreen,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await stationProvider
                                          .deleteStationSession(
                                              authorizationProvider
                                                  .user.bearerToken);
                                      setState(() {
                                        isVisibleExit = false;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.highlight_off_sharp,
                                          color: Colors.red,
                                          size: !isVisibleExit
                                              ? mainMenuButtonFontSize + 10
                                              : mainMenuButtonFontSizeSmall +
                                                  10,
                                        ),
                                        Text(
                                          ' Cancel active ride ',
                                          style: TextStyle(
                                            fontSize: !isVisibleExit
                                                ? mainMenuButtonFontSize
                                                : mainMenuButtonFontSizeSmall,
                                            color: Colors.white,
                                            fontFamily: 'ABeeZee',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
