import 'package:flutter/material.dart' show GlobalKey, NavigatorState;

import '../core/model/utm_model.dart';

class Global {
  static String appName = "Inventory App";

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static const double kButtonHeight = 52;
  static const int otpSeconds = 120 + 1;

  static const String validMobileNumber = "9033006262";
  static const String validPassword = "eVital@12";


  static UtmModel? utmData;
}
