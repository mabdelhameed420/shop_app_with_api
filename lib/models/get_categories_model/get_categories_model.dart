class CategoryModel {
  bool status;
  CategoryDataModel data;

  CategoryModel(this.status, this.data);

  factory CategoryModel.fromJason(Map<String, dynamic> jason) {
    final status = jason['status'];
    final data = CategoryDataModel.fromJason(jason['data']);
    return CategoryModel(status, data);
  }
}

class CategoryDataModel {
  int currentPage;
  List<DataModel> data = [];

  CategoryDataModel(this.currentPage, this.data);

  factory CategoryDataModel.fromJason(Map<String, dynamic> jason) {
    final currentPage = jason['current_page'];
    final categoryData = jason['data'] as List<dynamic>;
    final data = categoryData != null
        ? categoryData.map((data) => DataModel.fromJason(data)).toList()
        : <DataModel>[];
    return CategoryDataModel(currentPage, data);
  }
}

class DataModel {
  int id;
  String image;
  String name;

  DataModel(this.id, this.image, this.name);

  factory DataModel.fromJason(Map<String, dynamic> jason) {
    final id = jason['id'];
    final name = jason['name'];
    final image = jason['image'];
    return DataModel(id, image, name);
  }
}
