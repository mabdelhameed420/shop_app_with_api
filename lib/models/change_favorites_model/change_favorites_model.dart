class ChangeFavoritesModel{
  bool status;
  late String message;

  ChangeFavoritesModel(this.status, this.message);

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> jason){
    final status = jason['status'];
    final message = jason['message'];
    return ChangeFavoritesModel(status, message);
  }
}