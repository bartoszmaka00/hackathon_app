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
                height: 110,),

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
                              SizedBox(height: 45,),
                              Text('Carbon saved:',
                                style: TextStyle(
                                  color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Courgette',
                                ),
                              ),
                              Text('${authorizationProvider.user.carbonFootprint} kg',
                                style: TextStyle(
                                  color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Courgette',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: micemiddleGreen,
                          child: Column(
                            children: [
                              SizedBox(height: 45,),
                              Text('Points:',
                                style: TextStyle(
                                  color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Courgette',
                                ),),
                              Text('$points',
                                style: TextStyle(
                                  color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Courgette',
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
                        SizedBox(height: 20,),
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
                                  Icons.settings_overscan,
                                  color: Colors.black54,
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
                                    color: Colors.black54,
                                    fontFamily: 'Courgette',
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
                                  Navigator.pushNamed(context, '/history'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.article_outlined,
                                    color: Colors.black54,
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
                                      color: Colors.black54,
                                      fontFamily: 'Courgette',
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
                                      color: micemiddleGreen,
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
                                    color: Colors.black54,
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
                                      fontFamily: 'Courgette',
                                      color: Colors.black54,
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
                ],
              ),
            ),
          );
  }
}
