import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/screens/home/cubit/home_cubit.dart';
import 'package:quizu/src/screens/home/cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.index,
                onTap: (val) {
                  cubit.ChangeBottomNavBar(curentindex: val);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.score), label: 'Score'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ]),
            body: Stack(children: [
              SvgPicture.asset(
                AppAssets.appbackground,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              cubit.screens[cubit.index]
            ])
            //     SafeArea(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: IconButton(
            //             onPressed: () {
            //               SharedPreHelper.clearData().then((value) {
            //                 Navigator.of(context).pushNamedAndRemoveUntil(
            //                     AppRoutes.loginScreen, (route) => false);
            //               });
            //             },
            //             icon: const CircleAvatar(
            //               backgroundColor: Colors.white,
            //               child: Icon(
            //                 Icons.logout,
            //                 color: Colors.red,
            //               ),
            //             )),
            //       ),
            //     ),
            //     Expanded(child: cubit.screens[cubit.index])
            //   ],
            // ),

            );
      },
    );
  }
}
