class TokenModel {
  late bool success;
  late String message;
  
  TokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
