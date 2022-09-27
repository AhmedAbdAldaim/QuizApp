import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/local/sqlite_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/screens/result/cubit/result_states.dart';
import 'package:quizu/src/screens/result/result_screen.dart';

class ResultCubit extends Cubit<ResultStates> {
  ResultCubit() : super(InitState());
  static ResultCubit get(context) => BlocProvider.of(context);

  //post score
  sendScoreFun({required int score, required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      emit(LoadingResultState());
      DioHelper.postData(
          path: EndPointDioHelper.score,
          token: SharedPreHelper.getData(key: 'token'),
          data: {
            "score": score.toString(),
          }).then((value) {
            insertToScores(score: score);
        emit(SuccessResultState());
      }).catchError((error) {
        print(error);
        emit(ErrorResultState());
      });
    } else {
      defaultshowDialog(
          context: context,
          title: AppString.error,
          content: AppString.errorInternetConnection,
          onclicked: () {
            Navigator.of(context).pop();
            sendScoreFun(score: score, context: context);
          });
    }
  }

 

  String cureentdate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  insertToScores({required int score}) {
    SqliteHelpr.insertScore(score: score, date: cureentdate()).then((value) {
      print("insert Done!");
    }).catchError((error) {
      print(error);
    });
  }
}
