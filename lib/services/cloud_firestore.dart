import 'package:E_commerce/constants/field_name_firestore.dart';
import 'package:E_commerce/models/customer.dart';
import 'package:E_commerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  final _fireStore = Firestore.instance;
  void addProductsInfo(Product product) {
    _fireStore.collection(kProductCollectionName).document().setData({
      kProductName: product.name,
      kProductDescription: product.description,
      kProductOldPrice: product.oldPrice,
      kProductPrice: product.price,
      kProductImagePath: product.imagePath,
      kProductShopName: product.shopName
    });
  }
  void addCustomerInfo(Customer customer , String uid) {
    _fireStore.collection(kCustomerCollectionName).document(uid).setData({
      kCustomerName: customer.name,
      kCustomerEmail: customer.email,
      kCustomerGender: customer.gender,
      kCustomerPhoneNumber: customer.phoneNumber
    });
  }
  Stream<QuerySnapshot> loadDataOfProducts() {
    return _fireStore.collection(kProductCollectionName).snapshots();
  }
  Stream<DocumentSnapshot> loadDataOfCustomers(String docId) {
    return _fireStore.collection(kCustomerCollectionName).document(docId).snapshots();
  }

  void deleteProduct({String docId}){
    _fireStore.collection(kProductCollectionName).document(docId).delete();
  }

  void editProduct({Map<String , dynamic> data , String docId}){
    _fireStore.collection(kProductCollectionName).document().updateData(data);
  }

  addOrdersInfo(Map data , List<Product> products){
    var orderDocument = _fireStore.collection(K_ORDERS_PRODUCTS_COLLECTION_NAME).document();
    orderDocument.setData(data);
    for(var product in products){
      orderDocument.collection(K_ORDERS_PRODUCTS_COLLECTION_NAME).document().setData(
        {
          kProductName : product.name,
          kProductDescription : product.description,
          kProductPrice : product.price,
          kProductShopName : product.shopName,
          kProductQuantity : product.quantity
        }
      );
    }
  }



}
