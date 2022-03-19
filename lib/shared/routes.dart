import 'package:flutter/cupertino.dart';

import '../views/sign_in.dart';
import '../views/sign_up.dart';
import '../views/menu.dart';
import '../views/qr_view.dart';
import '../views/loading_screen.dart';
import '../views/points_history.dart';
import '../views/privileges.dart';
import '../views/purchase_menu.dart';
import '../views/qr_view2.dart';

var myRoutes = <String, WidgetBuilder>{
  '/': (context) => SignIn(),
  '/sign_in': (context) => SignIn(),
  '/menu': (context) => Menu(),
  '/sign_up': (context) => SignUp(),
  '/qr_test': (context) => QRViewExample(),
  '/loading': (context) => Loading(),
  '/history': (context) => PointsHistory(),
  '/privileges': (context) => Privileges(),
  '/qr_purchase': (context) => QRViewExample2(),
  '/purchase_menu': (context) => PurchaseMenu()
};
