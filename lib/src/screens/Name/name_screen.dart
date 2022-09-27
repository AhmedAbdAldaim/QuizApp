import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/screens/Name/cubit/name_cubit.dart';
import 'package:quizu/src/screens/Name/cubit/name_state.dart';

import '../../core/app_assets.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NameCubit(),
        child: BlocConsumer<NameCubit, NameStates>(
          listener: (context, state) {
            if (state is SuccessNameState) {
              context.loaderOverlay.hide();
              Navigator.of(context).pushNamed(AppRoutes.homeScreen);
            } else if (state is ErrorNameState) {
              context.loaderOverlay.hide();
              defaultshowDialog(
                  context: context,
                  title: AppString.error,
                  content: AppString.erroServer,
                  onclicked: () {
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            var cubit = NameCubit.get(context);
            return LoaderOverlay(
              overlayOpacity: 0.3,
              useDefaultLoading: true,
              overlayColor: Colors.black,
              child: Scaffold(
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
                                        height: AppMediaQuery.width(
                                                context: context) /
                                            4),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: defaultTextFormFaield(
                                                controller: controller,
                                                type: TextInputType.name,
                                                hint: 'Enter Your Name',
                                                action: TextInputAction.done,
                                                valid: (val) {
                                                  if (val.isEmpty) {
                                                    return 'Enter Your Name!';
                                                  }
                                                  return null;
                                                }))),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    defaultEleveBtn(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.nameFun(
                                                name: controller.text,
                                                context: context);
                                          }
                                        },
                                        title: AppString.done)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ));
  }
}
