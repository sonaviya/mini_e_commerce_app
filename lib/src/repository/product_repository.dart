import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductRepository {
  final _api = 'https://fakestoreapi.com/products';
  static const _cacheKey = 'products_cache';

  Future<List<Product>> fetchProducts() async {
    try {
      final res = await http.get(Uri.parse(_api)).timeout(Duration(seconds: 10));
      if (res.statusCode == 200) {
        final List decoded = json.decode(res.body);
        SharedPreferences.getInstance().then((p) => p.setString(_cacheKey, res.body));
        return decoded.map((e) => Product.fromJson(e)).toList();
      } else {
        return await _loadFromCache();
      }
    } catch (e) {
      return await _loadFromCache();
    }
  }

  Future<List<Product>> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      final List decoded = json.decode(cached);
      return decoded.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('No data available');
  }
}
