import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/pages/favorite.dart';
import 'package:E_commerce/pages/home.dart';
import 'package:E_commerce/pages/login.dart';
import 'package:E_commerce/pages/my_orders.dart';
import 'package:E_commerce/pages/profile_page.dart';
import 'package:E_commerce/pages/settings.dart';
import 'package:E_commerce/pages/shopping_cart.dart';
import 'package:E_commerce/providers/modal_hud.dart';
import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'file:///D:/Work/GemyFlutterApp/E_commerce/lib/functions/navigation_funs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerClass extends StatelessWidget {

  final List<String> titles = [
    "Home",
    "Profile",
    "My Cart",
    "Favorite",
    "My Orders",
    "Settings",
    "LogOut"
  ];
  final List<Object> pages = [
    Home(),
    Profile(),
    ShoppingCartPage(),
    Favorite(),
    MyOrders(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    var providerHud = Provider.of<ModalProgress>(context);
    return Drawer(
        child: ModalProgressHUD(
          inAsyncCall: providerHud.callValue,
          child: Scaffold(
      appBar: PreferredSize(
            child: AppBar(
              iconTheme:
                  IconThemeData(color: DARK_BLACK.withOpacity(0.7), size: 20),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            preferredSize: Size.fromHeight(100)),
      body: ListView.builder(
            itemCount: titles.length,
            itemBuilder: (BuildContext context, int index) {
              if(titles[index] == "LogOut"){
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    providerHud.inAsyncCallFun(true);
                    FirebaseAuth.instance.signOut();
                    providerHud.inAsyncCallFun(false);
                    shiftByReplacement(context, Login());
                  },
                  title: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 18,
                        color: DARK_BLACK.withOpacity(0.7),
                      ),
                    ),
                  ),
                );
              }else{
                return ListTile(
                  onTap: ()  async {
                    Navigator.pop(context);
                    normalShift(context, pages[index]);
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setBool(KEEP_USER_LOGGED_IN_KEY , false);
                  },
                  title: Center(
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: DARK_BLACK.withOpacity(0.7),
                      ),
                    ),
                  ),
                );
              }
            }),
    ),
        ));
  }
}
