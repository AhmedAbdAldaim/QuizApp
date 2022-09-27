import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/screens/splash/cubit/splash_cubit.dart';
import 'package:quizu/src/screens/splash/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (context)=> SplashCubit(),
        child: Builder(
          builder: (context) {
            SplashCubit.get(context).checkToken(context: context);
            return BlocConsumer<SplashCubit, SplashStates>(
              listener: (context, state) {
                if (state is SuccessSplashState) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.homeScreen,
                    (route) => false,
                  );
                } else if (state is ErrorSplashState && SharedPreHelper.getData(key: 'token')==null) {
                  Navigator.of(context).pushNamed(AppRoutes.loginScreen);
                }
              },
              builder: (context, state) {
                return Scaffold(
                  body: Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.appbackground,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Image.asset(
                              AppAssets.applogo,
                              height: AppMediaQuery.height(context: context) / 6,
                            ),
                            Image.asset(
                              AppAssets.apploader,
                              height: AppMediaQuery.height(context: context) / 6,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        ),
      );
 
  }
}
