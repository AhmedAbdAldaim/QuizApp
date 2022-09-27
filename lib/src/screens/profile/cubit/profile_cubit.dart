import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/local/sqlite_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/models/login_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quizu/src/models/user_info_model.dart';
import 'package:quizu/src/screens/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  UserInfoModel? userInfoModel;
  getUserInfoFun() {
    emit(LoadingProfileState());
    DioHelper.getData(
            path: EndPointDioHelper.userinfo,
            token: SharedPreHelper.getData(key: 'token'))
        .then((value) {
      userInfoModel = UserInfoModel.fromJson(value.data);
      getAllScoresSqlite();
      emit(SuccessProfileState(userInfoModel!));
    }).catchError((error) {
      print(error);
      emit(ErrorProfileState());
    });
  }

  var getAllScores = [];
  getAllScoresSqlite() {
    SqliteHelpr.getAllScores().then((value) {
      print(value);
      getAllScores = [];
      getAllScores.addAll(value);
      emit(GetScoreState());
    }).catchError((error) {
      print((error));
    });
  }
}
