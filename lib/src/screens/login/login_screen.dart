import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/screens/otp/otp_screen.dart';

import '../../core/app_assets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset(
              AppAssets.appbackground,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.applogo,
                              height:
                                  AppMediaQuery.width(context: context) / 4),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Card(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: defaultTextFormFailedIntal(
                                    context: context, controller: controller)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultEleveBtn(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => OtpScreen(
                                                phone: '$theNumber')));
                                  }
                                }
                              },
                              title: AppString.start)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
