class ChangePassword {
bool? status;
String? message;
Data? data;

ChangePassword({this.status, this.message, this.data});

ChangePassword.fromJson(Map<String, dynamic> json) {
status = json['status'];
message = json['message'];
data = json['data'] != null ? Data.fromJson(json['data']) : null;
}
}

class Data {
  String? email;

  Data({this.email});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
}
