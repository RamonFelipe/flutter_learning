import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final url =
        'https://flutter-update-e8e47.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    final oldStatus = isFavorite;

    _setIsFavorite(!isFavorite);

    try {
      var response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setIsFavorite(oldStatus);
      }
    } catch (e) {
      _setIsFavorite(oldStatus);
    }
  }

  void _setIsFavorite(bool oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }
}
