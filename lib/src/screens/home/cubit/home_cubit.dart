import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/datasourse/local/sqlite_helper.dart';
import 'package:quizu/src/screens/Leaderboard/leaderboard_screen.dart';
import 'package:quizu/src/screens/home/cubit/home_state.dart';
import 'package:quizu/src/screens/profile/profile_screen.dart';
import 'package:quizu/src/screens/quiz/quiz_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> screens = const [
    QuizScreen(),
    LeaderboardScreen(),
    ProfileScreen()
  ];

  ChangeBottomNavBar({required int curentindex}) {
    index = curentindex;
    emit(ChangeBottomNavBarState());
  }

//create db sqflite
  createDb() {
    SqliteHelpr.createDatabase().then((value) {
      print("created Success");
    }).catchError((error) {
      print(error);
    });
  }

}
