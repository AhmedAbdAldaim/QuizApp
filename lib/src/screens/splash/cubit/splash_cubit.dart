import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/models/token_model.dart';
import 'package:quizu/src/screens/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(InitSplashState());
  static SplashCubit get(context) => BlocProvider.of(context);

  TokenModel? tokenModel;
  checkToken({required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      emit(LoadingSplashState());
      DioHelper.getData(
              path: EndPointDioHelper.token,
              token: SharedPreHelper.getData(key: 'token'))
          .then((value) {
        tokenModel = TokenModel.fromJson(value.data);
        emit(SuccessSplashState());
      }).catchError((error) {
        print(error);
        emit(ErrorSplashState());
      });
    } else {
      defaultshowDialog(
          context: context,
          title: AppString.error,
          content: AppString.errorInternetConnection,
          onclicked: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.splashScreen, (route) => false);
          });
    }
  }
}
