import 'package:quizu/src/models/user_info_model.dart';
import 'package:quizu/src/screens/profile/cubit/profile_cubit.dart';

abstract class ProfileStates {}

class InitProfileState extends ProfileStates {}

class LoadingProfileState extends ProfileStates {}

class SuccessProfileState extends ProfileStates {
  final UserInfoModel userInfoModel;

  SuccessProfileState(this.userInfoModel);
}

class ErrorProfileState extends ProfileStates {}

class GetScoreState extends ProfileStates {}
