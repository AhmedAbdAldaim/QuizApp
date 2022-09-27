import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/config/app_routes.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/datasourse/local/sharedpre_helper.dart';
import 'package:quizu/src/screens/profile/cubit/profile_cubit.dart';
import 'package:quizu/src/screens/profile/cubit/profile_state.dart';
import '../../core/app_assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return SafeArea(
            child: (ConditionalBuilder(
          condition: cubit.userInfoModel != null,
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(20.0),
                          bottomStart: Radius.circular(20.0),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: IconButton(
                                onPressed: () {
                                  defaultshowDialog(
                                      context: context,
                                      title: 'Logout',
                                      content: 'Are You Sure To Logout?',
                                      onclicked: () {
                                        SharedPreHelper.clearData()
                                            .then((value) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  AppRoutes.loginScreen,
                                                  (route) => false);
                                        });
                                      });
                                },
                                icon: CircleAvatar(
                                    backgroundColor: Colors.red.shade900,
                                    child: const Icon(Icons.logout)))),
                        Image.asset(
                          AppAssets.applogo,
                          width: AppMediaQuery.width(context: context) / 7,
                        ),
                        Text(cubit.userInfoModel!.name,
                            style: Theme.of(context).textTheme.titleLarge!),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(cubit.userInfoModel!.mobile,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(AppString.myscores,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white)),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child:cubit.getAllScores.isEmpty?
                       const Center(child:Text('Empty')):
                       ListView.builder(
                          itemCount: cubit.getAllScores.length,
                          itemBuilder: (context, index) {
                            return buildItemMyScores(
                              date: cubit.getAllScores[index]['date'],
                              score: cubit.getAllScores[index]['socre'],
                            );
                          }),
                    ),
                  ))
                ],
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        )));
      },
    );
  }

  Widget buildItemMyScores({
    required date,
    required score,
  }) {
    return Card(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                date.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                score.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
