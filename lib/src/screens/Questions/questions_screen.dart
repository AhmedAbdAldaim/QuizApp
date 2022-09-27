import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/models/questions_model.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_cubit.dart';
import 'package:quizu/src/screens/Questions/cubit/questions_states.dart';
import 'package:quizu/src/screens/result/result_screen.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsCubit(),
      child: Builder(builder: (context) {
        QuestionsCubit.get(context).getAllquestionsFun(context: context);
        return BlocConsumer<QuestionsCubit, QuestionsStates>(
          listener: (context, state) {
            if (state is EndTimeState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => ResultScreen(
                          result: QuestionsCubit.get(context).myResult)),
                  (route) => false);
            }
          },
          builder: (context, state) {
            var cubit = QuestionsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Question - ${cubit.item + 1}'),
              ),
              body: WillPopScope(
                onWillPop: () async {
                  AudioPlayer()
                      .play(AssetSource(AppAssets.selected))
                      .then((value) {
                    defaultshowDialog(
                        context: context,
                        title: AppString.close,
                        content: AppString.msgclose,
                        onclicked: () {
                          if (state != SuccessQuestionsState()) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.homeScreen, (route) => false);
                          }
                          cubit.timer.cancel();
                          AudioPlayer()
                              .play(AssetSource(AppAssets.selected))
                              .then((value) {
                            AudioPlayer().dispose().then((value) {
                              cubit.timer.cancel();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoutes.homeScreen, (route) => false);
                            });
                          });
                        });
                  });
                  return false;
                },
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      AppAssets.appbackground,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    if (state is LoadingQuestionsState)
                      const Center(child: CircularProgressIndicator()),
                    if (state is SuccessQuestionsState)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    AppAssets.applogo,
                                    width:
                                        AppMediaQuery.width(context: context) /
                                            6,
                                  ),
                                  Card(
                                      color: Colors.red,
                                      child: Text(
                                        'Questions ${cubit.restOfQuestions} of 30 ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 10.0,
                                percent: cubit.start.toDouble() / 120.0,
                                center: Text(
                                  '${(Duration(seconds: cubit.start))}'
                                      .split('.')[0]
                                      .padLeft(6, '0')
                                      .replaceFirst(RegExp(r'0:'), ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red,
                                progressColor: Colors.amber,
                              ),
                              cubit.state is SuccessQuestionsState
                                  ? buildItemQuestion(
                                      model: cubit.questionsModel!
                                          .listQuestions[cubit.item],
                                      cubit: cubit,
                                      context: context)
                                  : const CircularProgressIndicator()
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget buildItemQuestion(
      {required QuestionsItem model,
      required QuestionsCubit cubit,
      required BuildContext context}) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red.shade900,
                border: Border.all(width: 4),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15.0),
            child: Text(
              model.question,
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(
          height: 20.0,
        ),
        buildItemOfAnswer(
            context: context,
            cubit: cubit,
            model: model,
            checkAnswer: 'a',
            theAnser: '(A)  ${model.a}'),
        const SizedBox(
          height: 10.0,
        ),
        buildItemOfAnswer(
            context: context,
            cubit: cubit,
            model: model,
            checkAnswer: 'b',
            theAnser: '(B)  ${model.b}'),
        const SizedBox(
          height: 10.0,
        ),
        buildItemOfAnswer(
            context: context,
            cubit: cubit,
            model: model,
            checkAnswer: 'c',
            theAnser: '(C)  ${model.c}'),
        const SizedBox(
          height: 10.0,
        ),
        buildItemOfAnswer(
            context: context,
            cubit: cubit,
            model: model,
            checkAnswer: 'd',
            theAnser: '(D)  ${model.d}'),
        if (cubit.skipQuestion == false)
          const SizedBox(
            height: 20.0,
          ),
        if (cubit.skipQuestion == false)
          buildSkipQuestions(context: context, cubit: cubit)
      ],
    );
  }

  Widget buildItemOfAnswer(
      {required BuildContext context,
      required QuestionsCubit cubit,
      required QuestionsItem model,
      required String checkAnswer,
      required String theAnser}) {
    return InkWell(
      onTap: () {
        if (model.correct == checkAnswer) {
          AudioPlayer()
              .play(AssetSource(AppAssets.successanswer))
              .then((value) {
            cubit.myResult = cubit.myResult + 1;
            cubit.nextQuestionsFun(context: context);
          });
        } else {
          AudioPlayer().play(AssetSource(AppAssets.wronganswer)).then((value) {
            cubit.myResult = 0;
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.wrongScreen, (route) => false);
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.5),
            border: Border.all(width: 4),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(15.0),
        child: Text(theAnser,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  Widget buildSkipQuestions(
      {required BuildContext context, required QuestionsCubit cubit}) {
    return Material(
      child: InkWell(
        onTap: () {
          AudioPlayer()
              .play(AssetSource(AppAssets.successanswer))
              .then((value) {
            cubit.item = cubit.item + 1;
            cubit.skipQuestionFun();
          });
        },
        child: Ink(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: const Text(AppString.skip),
          ),
        ),
      ),
    );
  }
}
