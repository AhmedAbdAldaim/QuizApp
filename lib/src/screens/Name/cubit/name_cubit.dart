import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/datasourse/remote/dio_helper.dart';
import 'package:quizu/src/datasourse/remote/end_points_dio_helper.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quizu/src/models/name_model.dart';
import 'package:quizu/src/screens/Name/cubit/name_state.dart';

class NameCubit extends Cubit<NameStates> {
  NameCubit() : super(InitNameState());
  static NameCubit get(context) => BlocProvider.of(context);

  NameModel? nameModel;
  nameFun({required String name, required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
      context.loaderOverlay.show();
      emit(LoadingNameState());
      DioHelper.postData(
          path: EndPointDioHelper.name,
          token: SharedPreHelper.getData(key: 'token'),
          data: {
            "name": name,
          }).then((value) {
        nameModel = NameModel.fromJson(value.data);
        emit(SuccessNameState(nameModel!));
      }).catchError((error) {
        print(error);
        emit(ErrorNameState());
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
