import 'dart:async';
import 'package:myapp/Models/favourite_pokemon.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'favorite_pokemon';

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null we instantiate it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Path to the database
    String path = join(await getDatabasesPath(), 'favorite_pokemon.db');

    // Create the database
    return await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY,
          name TEXT,
          imageUrl TEXT
        )
      ''');
    }, version: 1);
  }

  Future<void> insertPokemon(FavoritePokemon pokemon) async {
    final db = await database;
    await db.insert(tableName, pokemon.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavoritePokemon>> getAllFavoritePokemon() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return FavoritePokemon(
        id: maps[i]['id'],
        name: maps[i]['name'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }

  Future<void> deletePokemon(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
