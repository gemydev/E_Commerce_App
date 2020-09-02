import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/services/cloud_firestore.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:E_commerce/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:E_commerce/models/product.dart';

class AddProductPage extends StatelessWidget {
  String _pName, _pDescription, _pShopName, _pImagePath, _pOldPrice, _pPrice;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FireStore _fireStore = FireStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: LIGHT_BLACK,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
          child: ListView(
            children: <Widget>[
              TextFieldClass(
                  labelText: "Product Name",
                  hintText: " ",
                  validateHint: "Enter Product Name",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pName = value;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFieldClass(
                  labelText: "Description",
                  hintText: " ",
                  validateHint: "Enter Product Description",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pDescription = value;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFieldClass(
                  labelText: "ShopName",
                  hintText: "",
                  validateHint: "Enter Shop Name",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pShopName = value;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFieldClass(
                  labelText: "Old Price",
                  hintText: "",
                  validateHint: "Enter Product Old Price",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pOldPrice = value;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFieldClass(
                  labelText: "Price",
                  hintText: "",
                  validateHint: "Enter Product Price",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pPrice = value;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFieldClass(
                  labelText: "ImagePath",
                  hintText: "",
                  validateHint: "Enter ImagePath",
                  prefixIcon: Icons.arrow_forward_ios,
                  onSavedFun: (value) {
                    _pImagePath = value;
                  }),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                buttonName: "Add Product",
                fontSize: 18,
                onTapFun: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _fireStore.addProductsInfo(Product(
                        name: _pName,
                        shopName: _pShopName,
                        description: _pDescription,
                        oldPrice: _pOldPrice,
                        price: _pPrice,
                        imagePath: _pImagePath.trim()));
                    _formKey.currentState.reset();
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Something is wrong")));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
