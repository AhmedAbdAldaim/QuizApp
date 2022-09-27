class UserInfoModel {
  late String name;
  late String mobile;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }
}
