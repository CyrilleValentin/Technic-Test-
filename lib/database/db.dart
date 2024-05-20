

// ignore_for_file: avoid_print

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/user.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/dailyapp.db';
   
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE users( 
     id INTEGER PRIMARY KEY AUTOINCREMENT,
      gender TEXT,
     title TEXT,
       firstName TEXT,
        lastName TEXT,
         streetNumber TEXT,
          streetName TEXT, 
          city TEXT, 
          state TEXT,
         country TEXT, 
         postcode TEXT,
         latitude REAL,
         longitude REAL,
         email TEXT,
         uuid TEXT,
         username TEXT,
         password TEXT, 
         salt TEXT,
         md5 TEXT,
         sha1 TEXT,
         sha256 TEXT,
         dob TEXT,
         registered TEXT,
         phone TEXT,
         cell TEXT,
         idName TEXT,
         idValue TEXT,
         pictureLarge TEXT,
         pictureMedium TEXT,
         pictureThumbnail TEXT)

    ''');
  }
  
  Future<void> insertUser(UserModel user) async {
    final Database db = await database;
    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  Future<void> updateUser(UserModel user) async {
  final Database db = await database;
  await db.update(
    'users',
    user.toJson(),
    where: 'email = ?',
    whereArgs: [user.email],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  Future<void> deleteUser(String email) async {
  final Database db = await database;
  await db.delete('users', where: 'email = ?', whereArgs: [email]);
}


Future<List<dynamic>> loadUser() async {
  final Database db = await database;
  final List<Map<String, dynamic>> data = await db.query('users');
  return data.cast<dynamic>();
}
  Future<void> displayTableStructure() async {
    final Database db = await database;
    List<Map<String, dynamic>>? columns = await db.query('users', limit: 0);
    if (columns.isNotEmpty) {
      print("Table Structure for 'users':");
      columns[0].forEach((key, value) {
        print("$key: ${value.runtimeType}");
      });
    } else {
      print("Table 'users' does not exist or is empty.");
    }
  }

}
