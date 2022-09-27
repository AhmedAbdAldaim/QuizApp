import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/screens/otp/cubit/otp_cubit.dart';
import 'package:quizu/src/screens/otp/cubit/otp_state.dart';

class OtpScreen extends StatelessWidget {
  final String? phone;
  const OtpScreen({Key? key, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OtpCubit(),
        child: BlocConsumer<OtpCubit, OtpStates>(
          listener: (context, state) {
            if (state is SuccessOtpState) {
              if (state.loginModel.userStatus != null) {
                context.loaderOverlay.hide();
                SharedPreHelper.setData(
                        key: 'token', value: 'Bearer ${state.loginModel.token}')
                    .then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.nameScreen, (route) => false);
                  print(state.loginModel.userStatus);
                });
              } else {
                context.loaderOverlay.hide();
                SharedPreHelper.setData(
                        key: 'token', value: 'Bearer ${state.loginModel.token}')
                    .then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.homeScreen, (route) => false);
                  print('old user');
                });
              }
            } else if (state is ErrorOtpState) {
              context.loaderOverlay.hide();
              defaultshowDialog(
                  context: context,
                  title: 'Error',
                  content: 'Unauthorized! Your OTP is invalid',
                  onclicked: () {
                    Navigator.of(context).pop();
                  });
              print('ERROR');
            }
          },
          builder: (context, state) {
            var cubit = OtpCubit.get(context);
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: LoaderOverlay(
                  overlayColor: Colors.black,
                  overlayOpacity: 0.3,
                  useDefaultLoading: true,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.appbackground,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppString.codeSended} ${phone!}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                OtpTextField(
                                  numberOfFields: 4,
                                  showFieldAsBox: true,
                                  autoFocus: true,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                  focusedBorderColor: Color(0xFFFFB300),
                                  onCodeChanged: (String code) {},
                                  onSubmit: (String verificationCode) {
                                    cubit.otpFun(
                                        otp: verificationCode,
                                        mobile: phone!,
                                        context: context);
                                  }, // end onSubmit
                                ),
                              ])),
                    ],
                  ),
                ));
          },
        ));
  }
}
