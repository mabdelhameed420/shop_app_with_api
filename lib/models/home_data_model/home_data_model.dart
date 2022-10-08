class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel(this.status, this.data);

  factory HomeModel.fromJason(Map<String, dynamic> json) {
    final status = json['status'];
    final data = HomeDataModel.fromJason(json['data']);
    return HomeModel(status, data);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel(this.banners, this.products);

  factory HomeDataModel.fromJason(Map<String, dynamic> json) {
    final bannersData = json['banners'] as List<dynamic>;
    final banners = bannersData != null
        ? bannersData.map((data) => BannersModel.fromJason(data)).toList()
        : <BannersModel>[];
    final productsData = json['products'] as List<dynamic>;
    final products = productsData != null
        ? productsData.map((data) => ProductsModel.fromJason(data)).toList()
        : <ProductsModel>[];
    return HomeDataModel(banners, products);
  }
}

class BannersModel {
  int id;
  String? image;

  BannersModel(this.id, this.image);

  factory BannersModel.fromJason(Map<dynamic, dynamic> json) {
    final id = json['id'];
    final image = json['image'];
    return BannersModel(id, image);
  }
}

class ProductsModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String? description;
  List<dynamic>? images;

  ProductsModel({
    required this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.inFavorites,
    this.inCart,
    this.images,
    this.description,
  });

  factory ProductsModel.fromJason(Map<String, dynamic> json) {
    final id = json['id'];
    final price = json['price'];
    final oldPrice = json['old_price'];
    final discount = json['discount'];
    final image = json['image'];
    final name = json['name'];
    final inFavorites = json['in_favorites'];
    final inCart = json['in_cart'];
    final imagesData = [];
    json['images'].forEach((element) {
      imagesData.add(element);
    });
    final description = json['description'];
    return ProductsModel(
        id: id,
        price: price,
        oldPrice: oldPrice,
        name: name,
        inFavorites: inFavorites,
        inCart: inCart,
        discount: discount,
        description: description,
        image: image,
        images: imagesData);
  }
}
