import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_cubit.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_states.dart';
import 'package:quizu/src/screens/result/cubit/result_cubit.dart';
import 'package:quizu/src/screens/result/cubit/result_states.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatelessWidget {
  final int result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResultCubit()..sendScoreFun(score: result, context: context),
      child: BlocConsumer<ResultCubit, ResultStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ResultCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                SvgPicture.asset(
                  AppAssets.appbackground,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                state is ErrorResultState
                    ? defaultEleveBtn(
                        onPressed: () {
                          cubit.sendScoreFun(score: result, context: context);
                        },
                        title: AppString.tryAgain)
                    : ConditionalBuilder(
                        condition: state is SuccessResultState,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.appcup,
                                width: 200.0,
                                height: 200.0,
                              ),
                              const SizedBox(height: 20.0),
                              Text('You Have Compleate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.white)),
                              Text(
                                '$result Answers!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () async {
                                        await Share.share(
                                            'I answered $result correct answers in QuizU!');
                                      },
                                      icon: const Icon(Icons.share),
                                      label: const Text('Shared')),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                AppRoutes.homeScreen,
                                                (route) => false);
                                      },
                                      icon: Icon(Icons.home),
                                      label: Text('Home'))
                                ],
                              )
                            ],
                          );
                        },
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ))
              ],
            ),
          );
        },
      ),
    );
  }
}
