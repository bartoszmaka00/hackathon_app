import 'package:biker_mice_from_mars/shared/constans.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitChasingDots(color: Colors.white, size: 40),
      color: miceDarkGreen,
    );
  }
}
