import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/src/core/app_assets.dart';
import 'package:quizu/src/core/app_mediaquery.dart';
import 'package:quizu/src/core/app_strings.dart';
import 'package:quizu/src/core/components.dart';
import 'package:quizu/src/models/leaderboards_model.dart';
import 'package:quizu/src/screens/Leaderboard/cubit/leaderboard_cubit.dart';
import 'package:quizu/src/screens/Leaderboard/cubit/leaderboard_states.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaderboardsCubit, LeaderboardStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LeaderboardsCubit.get(context);
        return SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(AppAssets.applogo, width: AppMediaQuery.width(context: context)/8,),
                    const SizedBox(width: 10.0,),
                    Text(
                      'Leaderboard',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Card(
                  color: Colors.amber,
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        AppString.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text(
                      AppString.score,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                )),
                const SizedBox(height: 5.0,),
                state is ErrorLeaderboardsState
                    ? defaultEleveBtn(
                        onPressed: () {
                          cubit.getAllLeaderboardsFun(context: context);
                        },
                        title: AppString.tryAgain)
                    : Expanded(
                        child: ConditionalBuilder(
                            condition: state is SuccessLeaderboardsState,
                            builder: (context) {
                              return ListView.separated(
                                  itemBuilder: (context, index) =>
                                      buildItemTopScore(
                                          model: cubit.leaderboardModel!
                                              .listLeaderboards[index]),
                                  separatorBuilder: (context, index) => const SizedBox(height: 3,),
                                  itemCount: cubit.leaderboardModel!
                                      .listLeaderboards.length);
                            },
                            fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
                      )
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget buildItemTopScore({required LeaderboardsItem model}) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.name,
              textAlign: TextAlign.center,
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.score.toString(),
              textAlign: TextAlign.center,
            ),
          )),
        ],
      ),
    );
  }
}
