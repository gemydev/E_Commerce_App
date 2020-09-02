import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  Future<SharedPreferences> initSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  storeLoggedInState(bool state) {
    initSharedPrefs()
        .then((value) => value.setBool(KEEP_USER_LOGGED_IN_KEY, state));
  }

  storeEmail(String email) {
    initSharedPrefs().then((value) => value.setString(EMAIL_KEY, email));
  }

  storeFirstName(String firstName) {
    initSharedPrefs()
        .then((value) => value.setString(FIRST_NAME_KEY, firstName));
  }

  storeLastName(String lastName) {
    initSharedPrefs().then((value) => value.setString(LAST_NAME_KEY, lastName));
  }

  storeGender(String gender) {
    initSharedPrefs().then((value) => value.setString(GENDER_KEY, gender));
  }

  storePhoneNumber(String phoneNumber) {
    initSharedPrefs()
        .then((value) => value.setString(PHONE_NUMBER_KEY, phoneNumber));
  }

  storeAddressLane(String addressLane) {
    initSharedPrefs()
        .then((value) => value.setString(ADDRESS_LANE_KEY, addressLane));
  }

  storeCity(String city) {
    initSharedPrefs().then((value) => value.setString(CITY_KEY, city));
  }

   getCity() async {
    initSharedPrefs().then((value) => value.getString(CITY_KEY));
  }

  getAddressLane() {
    initSharedPrefs().then((value) => value.getString(ADDRESS_LANE_KEY));
  }

  getEmail() {
    initSharedPrefs().then((value) => value.getString(EMAIL_KEY));
  }

  getPhoneNumber() {
    initSharedPrefs().then((value) => value.getString(PHONE_NUMBER_KEY));
  }

  getFirstName() {
    initSharedPrefs().then((value) => value.getString(FIRST_NAME_KEY));
  }

  getLastName() {
    initSharedPrefs().then((value) => value.getString(LAST_NAME_KEY));
  }

  getGender(){
    initSharedPrefs().then((value) => value.getString(GENDER_KEY));
  }
}
