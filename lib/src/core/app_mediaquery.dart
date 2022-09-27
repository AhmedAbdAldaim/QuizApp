import 'package:flutter/material.dart';

class AppMediaQuery {
  static double width({required BuildContext context}) =>
      MediaQuery.of(context).size.width;
  static double height({required BuildContext context}) =>
      MediaQuery.of(context).size.height;
}
