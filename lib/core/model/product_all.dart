class ProductAll {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  Category? category;
  String? mrp; // Added field for MRP
  String? discount; // Added field for discount
  bool isAddedToCart; // New field to track if added to cart

  ProductAll({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
    this.mrp,
    this.discount,
    this.isAddedToCart = false, // Default to not added
  });

  factory ProductAll.fromJson(Map<String, dynamic> json) {
    return ProductAll(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images']),
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      mrp: json['mrp'],  // Parsing MRP
      discount: json['discount'],  // Parsing Discount
      isAddedToCart: json['isAddedToCart'] ?? false, // Default to false
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['images'] = images;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['mrp'] = mrp;  // Adding MRP to JSON output
    data['discount'] = discount;  // Adding Discount to JSON output
    data['isAddedToCart'] = isAddedToCart; // Adding isAddedToCart to JSON
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category({this.id, this.name, this.image, this.creationAt, this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
