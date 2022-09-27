import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';

class WrongScreen extends StatelessWidget {
  const WrongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
      children: [
        SvgPicture.asset(
          AppAssets.appbackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.appwrong,
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text('Wrong Answer',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.questionsScreen, (route) => false);
                      },
                    icon: const Icon(Icons.replay),
                    label: const Text('Try Again')),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.homeScreen, (route) => false);
                    },
                    icon: Icon(Icons.home),
                    label: Text('Home'))
              ],
            )
          ],
        ),
      ],
    ));
  }
}
