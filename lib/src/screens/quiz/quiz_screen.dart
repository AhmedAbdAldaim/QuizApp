import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_strings.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppString.aboutQuize1,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white)),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40),
                  shape: const CircleBorder(),
                  elevation: 10.0,
                  shadowColor: Colors.grey),
              onPressed: () {
                AudioPlayer()
                    .play(AssetSource(AppAssets.selected))
                    .then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.questionsScreen, (route) => false);
                });
              },
              child: const Text(AppString.quizMe)),
          const SizedBox(
            height: 10.0,
          ),
          Text(AppString.aboutQuize2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white)),
        ],
      ),
    ));
  }
}
