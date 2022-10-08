class ProfileModel {
  bool status;
  ProfileDataModel data;

  ProfileModel(this.status, this.data);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final data = ProfileDataModel.fromJson(json['data']);
    return ProfileModel(status, data);
  }

}

class ProfileDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  ProfileDataModel(
      this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.points,
        this.credit,
        this.token);

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];
    final phone = json['phone'];
    final image = json['image'];
    final points = json['points'];
    final credit = json['credit'];
    final token = json['token'];
    return ProfileDataModel(id, name, email, phone, image, points, credit, token);
  }
}
