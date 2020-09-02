import 'dart:io';
import 'package:E_commerce/shared_prefs/prefs_functions.dart';
import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:path/path.dart' as pathPackage;
import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/pages/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String pathOfDefaultProfileImage =
      "assets/images/defaultProfileImage.jpg";
  SharedFunctions _sharedFunctions = SharedFunctions();
  File _imageFile;
  String _firstName = '', _lastName='', _gender='', _phoneNumber='', _addressLane='', _city='';
  String content;
  String _profileImageUrl;
  Icon saveIcon = Icon(
    Icons.save,
  );

  setData() async {
    _sharedFunctions.storeFirstName(_firstName);
    _sharedFunctions.storeGender(_gender);
    _sharedFunctions.storeLastName(_lastName);
    _sharedFunctions.storePhoneNumber(_phoneNumber);
    _sharedFunctions.storeAddressLane(_addressLane);
    _sharedFunctions.storeCity(_city);
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _firstName = (sharedPreferences.getString(FIRST_NAME_KEY) ?? '');
      _lastName = (sharedPreferences.getString(LAST_NAME_KEY) ?? '');
      _gender = (sharedPreferences.getString(GENDER_KEY) ?? '');
      _phoneNumber = (sharedPreferences.getString(PHONE_NUMBER_KEY) ?? '');
      _addressLane = (sharedPreferences.getString(ADDRESS_LANE_KEY) ?? '');
      _city = (sharedPreferences.getString(CITY_KEY) ?? '');
    });
  }

  @override
  void initState() {
    getData();
    debugPrint(_phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: DARK_BLACK.withOpacity(0.7),
            ),
            onPressed: () => shiftByReplacement(context, Home()),
          ),
        ),
        iconTheme: IconThemeData(
          color: DARK_BLACK.withOpacity(0.7),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        color: DARK_BLACK, fontSize: 30, letterSpacing: 1.5),
                  ),
                ),
                Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _imageFile == null
                            ? AssetImage(pathOfDefaultProfileImage)
                            : FileImage(_imageFile),
                        radius: 55,
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              pickImage();
                              uploadImage();
                            }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                _infoField(
                    fieldName: "First Name",
                    initialValue: _firstName,
                    onSavedFun: (value) {
                      _firstName = value;
                    }),
                _infoField(
                    fieldName: "Last Name",
                    initialValue: _lastName,
                    onSavedFun: (value) {
                      _lastName = value;
                    }),
                _infoField(
                    fieldName: "Gender",
                    initialValue: _gender,
                    onSavedFun: (value) {
                      _gender = value;
                    }),
                _infoField(
                    fieldName: "Phone Number",
                    initialValue: _phoneNumber,
                    onSavedFun: (value) {
                      _phoneNumber = value;
                    }),
                _infoField(
                    fieldName: "AddressLane",
                    initialValue: _addressLane,
                    onSavedFun: (value) {
                      _addressLane = value;
                    }),
                _infoField(
                    initialValue: _city,
                    fieldName: "City",
                    onSavedFun: (value) {
                      _city = value;
                    }),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomButton(
                        buttonName: "Save",
                        fontSize: 20,
                        onTapFun: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            setData();
                            print("done....");
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoField(
      {String fieldName,
      String initialValue,
      String hintText,
      Function onSavedFun}) {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return "Enter The $fieldName";
        } else {
          return null;
        }
      },
      initialValue: initialValue,
      onSaved: onSavedFun,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(color: DARK_BLACK.withOpacity(0.7), fontSize: 18),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: DARK_BLACK.withOpacity(0.9)),
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }

  void uploadImage() async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://gemy-store.appspot.com');
      StorageReference reference =
          storage.ref().child(pathPackage.basename(_imageFile.path));
      StorageUploadTask storageUploadTask = reference.putFile(_imageFile);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Done...")));
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      print(_profileImageUrl);
      print(imageUrl);
      setState(() {
        _profileImageUrl = imageUrl;
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void downloadImage() async {
    try {
      var imageId = await ImageDownloader.downloadImage(_profileImageUrl);
      var imagePath = await ImageDownloader.findPath(imageId);
      File image = File(imagePath);
      setState(() {
        _imageFile = image;
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
