class NameModel {
  late bool success;
  late String message;
  late String name;
  late String mobile;

  NameModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    name = json['name'];
    mobile = json['mobile'];
  }
}
