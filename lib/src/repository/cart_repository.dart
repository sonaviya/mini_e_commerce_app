import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class CartItem {
  final int productId;
  final String title;
  final double price;
  int quantity;
  final String image;

  CartItem({required this.productId, required this.title, required this.price, required this.quantity, required this.image});

  Map<String, dynamic> toMap() => {
    'productId': productId,
    'title': title,
    'price': price,
    'quantity': quantity,
    'image': image,
  };

  factory CartItem.fromMap(Map<String, dynamic> m) => CartItem(
    productId: m['productId'],
    title: m['title'],
    price: (m['price'] as num).toDouble(),
    quantity: m['quantity'],
    image: m['image'],
  );
}

class CartRepository {
  static Database? _db;
  static CartRepository? _instance;

  CartRepository._();

  static Future<CartRepository> getInstance() async {
    if (_instance != null) return _instance!;
    _instance = CartRepository._();
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'cart.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('''
        CREATE TABLE cart(
          productId INTEGER PRIMARY KEY,
          title TEXT,
          price REAL,
          quantity INTEGER,
          image TEXT
        )
      ''');
    });
    return _instance!;
  }

  Future<List<CartItem>> loadCart() async {
    final maps = await _db!.query('cart');
    return maps.map((m) => CartItem.fromMap(m)).toList();
  }

  Future<void> upsertItem(CartItem item) async {
    await _db!.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeItem(int productId) async {
    await _db!.delete('cart', where: 'productId=?', whereArgs: [productId]);
  }

  Future<void> clear() async {
    await _db!.delete('cart');
  }
}
