import 'dart:io';
import 'package:E_commerce/database/const_titles.dart';
import 'package:E_commerce/models/address.dart';
import 'package:E_commerce/models/card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'appDB.db';
    var storeDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return storeDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $ADDRESSES_TABLE_NAME($ADDRESS_ID INTEGER PRIMARY KEY AUTOINCREMENT,$ADDRESS_LANE TEXT,$CITY TEXT,$POSTAL_CODE TEXT)');
    await db.execute(
        'CREATE TABLE $CARDS_TABLE_NAME($CARD_ID INTEGER PRIMARY KEY AUTOINCREMENT, $CARD_NUMBER TEXT, $CARD_EXPIRATION_DATE TEXT,$CARD_CVV TEXT)');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<int> insertAddress(Address address) async {
    Database db = await this.database;
    var result = await db.insert(ADDRESSES_TABLE_NAME, address.toMap());
    return result;
  }

  Future<int> updateAddress(Address address) async {
    Database db = await this.database;
    var result = await db.update(ADDRESSES_TABLE_NAME, address.toMap(),
        where: '$ADDRESS_ID = ?', whereArgs: [address.id]);
    return result;
  }

  Future<int> deleteAddress(Address address) async {
    var db = await this.database;
    int deleteId = address.id;
    int result = await db.rawDelete(
        'DELETE FROM $ADDRESSES_TABLE_NAME WHERE $ADDRESS_ID = $deleteId');
    return result;
  }

  Future<int> getCountOfAddresses() async {
    var db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $ADDRESSES_TABLE_NAME');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Map<String, dynamic>>> getSpecificAddress(int id) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT $ADDRESS_LANE , $CITY FROM $ADDRESSES_TABLE_NAME WHERE $ADDRESS_ID = $id ');
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> getAllAddressesMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $ADDRESSES_TABLE_NAME order by $ADDRESS_ID ASC');
    return result.toList();
  }

  Future<List<Address>> getAddressesList() async {
    var addressMapList = await getAllAddressesMapList();
    int count = addressMapList.length;
    List<Address> addressList = List<Address>();
    for (int i = 0; i < count; i++) {
      addressList.add(Address.fromMapObject(addressMapList[i]));
    }
    return addressList;
  }

  Future<int> insertCard(CreditCard card) async {
    Database db = await this.database;
    var result = await db.insert(CARDS_TABLE_NAME, card.toMap());
    return result;
  }

  Future<int> updateCard(CreditCard card) async {
    Database db = await this.database;
    var result = await db.update(CARDS_TABLE_NAME, card.toMap(),
        where: '$CARD_ID = ?', whereArgs: [card.id]);
    return result;
  }

  Future<int> deleteCard(CreditCard card) async {
    var db = await this.database;
    int deleteId = card.id;
    int result = await db
        .rawDelete('DELETE FROM $CARDS_TABLE_NAME WHERE $CARD_ID = $deleteId');
    return result;
  }

  Future<int> getCountOfCards() async {
    var db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $CARDS_TABLE_NAME');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllCardsMapList() async {
    Database db = await this.database;
    var result = await db
        .rawQuery('SELECT * FROM $CARDS_TABLE_NAME order by $CARD_ID ASC');
    return result.toList();
  }

  Future<List<CreditCard>> getCardsList() async {
    var cardsMapList = await getAllCardsMapList();
    int count = cardsMapList.length;
    List<CreditCard> cardsList = List<CreditCard>();
    for (int i = 0; i < count; i++) {
      cardsList.add(CreditCard.fromMap(cardsMapList[i]));
    }
    return cardsList;
  }
}
