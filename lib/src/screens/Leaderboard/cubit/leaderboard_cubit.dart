import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/models/leaderboards_model.dart';
import 'package:quizu/src/screens/Leaderboard/cubit/leaderboard_states.dart';

class LeaderboardsCubit extends Cubit<LeaderboardStates> {
  LeaderboardsCubit() : super(InitState());
  static LeaderboardsCubit get(context) => BlocProvider.of(context);

  LeaderboardsModel? leaderboardModel;

  getAllLeaderboardsFun({required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      emit(LoadingLeaderboardsState());
      DioHelper.getData(
              path: EndPointDioHelper.topScores,
              token: SharedPreHelper.getData(key: 'token'))
          .then((value) {
        leaderboardModel = LeaderboardsModel.fromJson(value.data);
        emit(SuccessLeaderboardsState());
      }).catchError((error) {
        print(error);
        emit(ErrorLeaderboardsState());
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
}
