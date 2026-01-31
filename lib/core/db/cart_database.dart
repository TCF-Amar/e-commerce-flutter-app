import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;
  Database? get db => _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath$filePath';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final realType = 'REAL NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
        CREATE TABLE $tableCart (
          ${CartFields.id} $idType,
          ${CartFields.slug} $textType,
          ${CartFields.title} $textType,
          ${CartFields.price} $realType,
          ${CartFields.quantity} $integerType,
          ${CartFields.image} $textType,
          ${CartFields.size} $textType
        )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> create(CartItemModel item) async {
    final db = await instance.database;
    await db.insert(tableCart, item.toJson());
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete(tableCart, where: '${CartFields.id} = ?', whereArgs: [id]);
  }

  Future<void> update(CartItemModel item) async {
    final db = await instance.database;
    await db.update(
      tableCart,
      item.toJson(),
      where: '${CartFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<List<CartItemModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableCart);
    return result.map((json) => CartItemModel.fromJson(json)).toList();
  }
}
