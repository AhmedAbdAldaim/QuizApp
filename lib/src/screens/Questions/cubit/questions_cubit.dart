import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/models/questions_model.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_states.dart';
import 'package:quizu/src/screens/result/result_screen.dart';

class QuestionsCubit extends Cubit<QuestionsStates> {
  QuestionsCubit() : super(InitState());
  static QuestionsCubit get(context) => BlocProvider.of(context);

  late Timer timer;
  int start = 120;
  countdowntimerFun() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (start == 0) {
        timer.cancel();
        emit(EndTimeState());
      } else {
        start--;
        if (start == 4) {
          await AudioPlayer().play(AssetSource(AppAssets.countdown));
        }
        emit(SuccessQuestionsState());
      }
    });
  }

  int item = 0;
  int myResult = 0;
  int restOfQuestions = 30;
  bool skipQuestion = false;
  QuestionsModel? questionsModel;

  getAllquestionsFun({required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      emit(LoadingQuestionsState());
      DioHelper.getData(
              path: EndPointDioHelper.questions,
              token: SharedPreHelper.getData(key: 'token'))
          .then((value) {
        questionsModel = QuestionsModel.fromJson(value.data);
        countdowntimerFun();
        emit(SuccessQuestionsState());
      }).catchError((error) {
        print(error);
        emit(ErrorQuestionsState());
      });
    } else {
      defaultshowDialog(
          context: context,
          title: AppString.error,
          content: AppString.errorInternetConnection,
          onclicked: () {
            Navigator.of(context).pop();
          });
    }
  }

  nextQuestionsFun({required BuildContext context}) {
    if (questionsModel!.listQuestions.length == item + 1) {
      timer.cancel();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => ResultScreen(
                    result: myResult,
                  )),
          (route) => false);
    } else {
      restOfQuestions--;
      item++;
      emit(SuccessQuestionsState());
    }
  }

  skipQuestionFun() {
    skipQuestion = true;
    restOfQuestions--;
    emit(SuccessQuestionsState());
  }
}
