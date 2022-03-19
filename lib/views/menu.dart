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
    var stationProvider = Provider.of<StationProvider>(context, listen: false);
    // stationProvider.station.startStation == 0
    int points = authorizationProvider.user.points;
    bool isVisibleExit =
        stationProvider.station.startStation == 0 ? false : true;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: miceLightGreen,
            appBar: AppBar(
              backgroundColor: miceDarkGreen,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text('You\'ve got $points points!'),
            ),
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'So far you\'ve saved ${authorizationProvider.user.carbonFootprint} kgs of carbon'),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: miceLightGreen,
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
                              Icons.settings_overscan,
                              color: Colors.white,
                              size: !isVisibleExit
                                  ? mainMenuButtonFontSize + 10
                                  : mainMenuButtonFontSizeSmall + 10,
                            ),
                            Text(
                              ' Scan QR Code',
                              style: TextStyle(
                                fontSize: !isVisibleExit
                                    ? mainMenuButtonFontSize
                                    : mainMenuButtonFontSizeSmall,
                                color: Colors.black,
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
                                  color: miceLightGreen,
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
                                    ? mainMenuButtonFontSize + 10
                                    : mainMenuButtonFontSizeSmall + 10,
                              ),
                              Text(
                                ' History',
                                style: TextStyle(
                                  fontSize: !isVisibleExit
                                      ? mainMenuButtonFontSize
                                      : mainMenuButtonFontSizeSmall,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
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
                                  color: miceLightGreen,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/privileges'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.wallet_giftcard,
                                color: Colors.white,
                                size: !isVisibleExit
                                    ? mainMenuButtonFontSize + 10
                                    : mainMenuButtonFontSizeSmall + 10,
                              ),
                              Text(
                                ' My privileges',
                                style: TextStyle(
                                  fontSize: !isVisibleExit
                                      ? mainMenuButtonFontSize
                                      : mainMenuButtonFontSizeSmall,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: isVisibleExit,
                      child: SizedBox(
                        width: mainMenuButonWidthSmall,
                        height: mainMenuButonHeightSmall,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: miceLightGreen,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await stationProvider.deleteStationSession(
                                  authorizationProvider.user.bearerToken);
                              setState(() {
                                isVisibleExit = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.highlight_off_sharp,
                                  color: Colors.red,
                                  size: !isVisibleExit
                                      ? mainMenuButtonFontSize + 10
                                      : mainMenuButtonFontSizeSmall + 10,
                                ),
                                Text(
                                  ' Cancel the ride ',
                                  style: TextStyle(
                                    fontSize: !isVisibleExit
                                        ? mainMenuButtonFontSize
                                        : mainMenuButtonFontSizeSmall,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: miceLightGreen,
            appBar: AppBar(
              backgroundColor: miceDarkGreen,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text('You\'ve got $points points!'),
            ),
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'You saved ${authorizationProvider.user.carbonFootprint} kgs of carbon so far'),
                    SizedBox(
                      width: mainMenuButonWidth,
                      height: mainMenuButonHeight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: miceLightGreen,
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
                              Icons.settings_overscan,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            Text(
                              ' Scan QR Code',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
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
                      width: mainMenuButonWidth,
                      height: mainMenuButonHeight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: miceLightGreen,
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
                                size: 40.0,
                              ),
                              Text(
                                ' History',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: mainMenuButonWidth,
                      height: mainMenuButonHeight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: miceLightGreen,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/privileges'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.wallet_giftcard,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              Text(
                                ' My privileges',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
