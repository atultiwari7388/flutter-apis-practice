import 'dart:convert';

import 'package:apisflutter/Models/WorldStatsModel.dart';
import 'package:apisflutter/utils/app_url.utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StatsApiServices {
  Future<WorldStatsModel> worldStatsRecord() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.allWorldsData));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WorldStatsModel.fromJson(data);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong" + e.toString());
      }
    }

    throw Exception("Something went wrong");
  }
}
