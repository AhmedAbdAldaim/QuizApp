class LeaderboardsModel {
  List<LeaderboardsItem> listLeaderboards = [];
  LeaderboardsModel.fromJson(List<dynamic> list) {
    for (var element in list) {
      listLeaderboards.add(LeaderboardsItem.fromJson(element));
    }
  }
}

class LeaderboardsItem {
  late String name;
  late int score;

  LeaderboardsItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }
}
