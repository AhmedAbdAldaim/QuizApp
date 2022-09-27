

import 'package:quizu/src/models/login_model.dart';

abstract class OtpStates {}

class InitOtpState extends OtpStates {}

class LoadingOtpState extends OtpStates {}

class SuccessOtpState extends OtpStates {
  final LoginModel loginModel;
  SuccessOtpState(this.loginModel);
}

class ErrorOtpState extends OtpStates {
  
}
