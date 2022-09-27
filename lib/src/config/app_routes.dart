import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/screens/Name/name_screen.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_cubit.dart';
import 'package:quizu/src/screens/Questions/questions_screen.dart';
import 'package:quizu/src/screens/home/home_screen.dart';
import 'package:quizu/src/screens/login/login_screen.dart';
import 'package:quizu/src/screens/otp/otp_screen.dart';
import 'package:quizu/src/screens/result/result_screen.dart';
import 'package:quizu/src/screens/splash/splashscreen.dart';
import 'package:quizu/src/screens/wrong_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String otpScreen = '/otp';
  static const String nameScreen = '/name';
  static const String homeScreen = '/home';
  static const String questionsScreen = '/questions';
  static const String wrongScreen = '/wrong';
  static const String resultScreen = '/result';
}

Route<dynamic>? onGen(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case AppRoutes.loginScreen:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case AppRoutes.otpScreen:
      return MaterialPageRoute(builder: (_) => OtpScreen());
    case AppRoutes.nameScreen:
      return MaterialPageRoute(builder: (_) => NameScreen());
    case AppRoutes.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case AppRoutes.questionsScreen:
      return MaterialPageRoute(builder: (_) => const QuestionsScreen());
    case AppRoutes.wrongScreen:
      return MaterialPageRoute(builder: (_) => const WrongScreen());

  }
}
