import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:quizu/src/models/login_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quizu/src/screens/otp/cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(InitOtpState());
  static OtpCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  otpFun(
      {required String otp,
      required String mobile,
      required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      context.loaderOverlay.show();
      emit(LoadingOtpState());
      DioHelper.postData(
          path: EndPointDioHelper.login,
          data: {"OTP": otp, "mobile": mobile}).then((value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(SuccessOtpState(loginModel!));
      }).catchError((error) {
        print(error);
        emit(ErrorOtpState());
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
