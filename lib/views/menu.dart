import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/constans.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var authorizationProvider =
        Provider.of<AuthorizationProvider>(context, listen: false);
    int points = authorizationProvider.user.points;
    return Scaffold(
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
            borderRadius: BorderRadius.all(
                Radius.circular(20)
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                width: mainMenuButonWidth,
                height: mainMenuButonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: miceLightGreen,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/qr_test'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.settings_overscan,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      Text(' Scan QR Code',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: miceLightGreen,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        Text(' History',
                          style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),),
                      ],
                    )),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: mainMenuButonWidth,
                height: mainMenuButonHeight,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: miceLightGreen,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/privileges'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.wallet_giftcard,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        Text(' My privileges',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),),
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
