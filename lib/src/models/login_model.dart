class LoginModel {
  late bool success;
  late String message;
  late String token;
  late String? name;
  late String? mobile;
  late String? userStatus;

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
    userStatus = json['user_status'];
  }
}
