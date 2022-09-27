import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/config/app_theme.dart';
import 'package:quizu/src/core/observer.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/screens/Leaderboard/cubit/leaderboard_cubit.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_cubit.dart';
import 'package:quizu/src/screens/home/cubit/home_cubit.dart';
import 'package:quizu/src/screens/profile/cubit/profile_cubit.dart';
import 'package:quizu/src/screens/result/result_screen.dart';
import 'package:quizu/src/screens/splash/cubit/splash_cubit.dart';
import 'package:quizu/src/screens/splash/splashscreen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreHelper.initSharedPredFrencese();
  DioHelper.initDio();
  runApp(const QuizeApp());
}

class QuizeApp extends StatelessWidget {
  const QuizeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..createDb()),
        BlocProvider(
            create: (context) =>
                LeaderboardsCubit()..getAllLeaderboardsFun(context: context)),
        BlocProvider(create: (context) => ProfileCubit()..getUserInfoFun()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ligthTheme,
        onGenerateRoute: onGen,
      ),
    );
  }
}
