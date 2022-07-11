import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Models/ProductsModel.dart';

class ApiServices {
  Future<ProductsModel> getProductData() async {
    final response = await http.get(
        Uri.parse("https://webhook.site/e7a3174a-bc31-4074-a15a-3b527f056384"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print("Something Went wrong");
      }
    }
    return ProductsModel.fromJson(data);
  }
}
