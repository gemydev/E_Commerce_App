

class Product {
  String name;
  String description;
  String price;
  String oldPrice;
  String imagePath ;
  String shopName;
  String id;
  int quantity = 1;
  String size ;
  int orderTimes ;
  bool favorite  ;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.imagePath,
    this.shopName,
    this.quantity,
    this.size,
    this.orderTimes,
    this.favorite
  });
}


