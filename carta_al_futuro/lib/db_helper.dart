import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "letters.db";
  static const _databaseVersion = 1;
  static const table = 'letters';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        email TEXT NOT NULL,
        deliveryTime TEXT NOT NULL,
        dateCreated TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertLetter(Map<String, dynamic> letter) async {
    final db = await database;
    return await db.insert(table, letter);
  }
}
