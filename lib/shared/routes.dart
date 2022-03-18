import 'package:flutter/cupertino.dart';

import '../views/sign_in.dart';
import '../views/sign_up.dart';
import '../views/menu.dart';
import '../views/qr_view.dart';

var myRoutes = <String, WidgetBuilder>{
  '/': (context) => SignIn(),
  '/sign_in': (context) => SignIn(),
  '/menu': (context) => Menu(),
  '/sign_up': (context) => SignUp(),
  '/qr_test': (context) => QRViewExample(),
};
