import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunsong/services/map_api.dart';
import 'package:nunsong/services/store_api.dart';

class ApiService {
  static const baseurl_place =
      'https://ubunj66fwhu2yktk4tw4noo77e0fvmrb.lambda-url.ap-northeast-2.on.aws';
  static const baseurl_restaurant =
      'https://zg4skp4oc3q2cfd2ymkml3gcqe0rfedf.lambda-url.ap-northeast-2.on.aws';
  static const baseurl_store =
      'https://ywer37hwy6x3rh3tzqwwwaox2m0mpgqh.lambda-url.ap-northeast-2.on.aws';
  static const baseurl_cafe =
      'https://fandeh63wy3vnm3eoei5xrh3wy0hjooo.lambda-url.ap-northeast-2.on.aws';

  static Future<MapModel> fetchDatafromAPI(String pname) async {
    final url = Uri.parse('$baseurl_place/?pname=$pname');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responseBody =
          const Utf8Decoder().convert(response.bodyBytes);
      final Map<String, dynamic> mapinfo = jsonDecode(responseBody);
      mapinfo['location'] = pname;
      return MapModel.fromJson(mapinfo);
    } else {
      throw Exception('Failed to load map data');
    }
  }

  static Future<List<StoreModel>> getRestaurant(
      String latitude, String longitude) async {
    List<StoreModel> RestaurantInstances = [];
    final url = Uri.parse(
        '$baseurl_restaurant/?latitude=$latitude&&longitude=$longitude');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = jsonDecode(response.body);
      for (var restaurantJson in restaurantsJson) {
        final restaurant = StoreModel.fromJson(restaurantJson);
        RestaurantInstances.add(restaurant);
      }
      return RestaurantInstances;
    }
    throw Error();
  }

  static Future<List<StoreModel>> getCafe(
      String latitude, String longitude) async {
    List<StoreModel> CafeInstances = [];
    final url =
        Uri.parse('$baseurl_cafe/?latitude=$latitude&&longitude=$longitude');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> cafesJson = jsonDecode(response.body);
      for (var cafeJson in cafesJson) {
        final cafe = StoreModel.fromJson(cafeJson);
        CafeInstances.add(cafe);
      }
      return CafeInstances;
    }
    throw Error();
  }

  static Future<List<StoreModel>> getStore(
      String latitude, String longitude) async {
    List<StoreModel> StoreInstances = [];
    final url =
        Uri.parse('$baseurl_store/?latitude=$latitude&&longitude=$longitude');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> storesJson = jsonDecode(response.body);
      for (var storeJson in storesJson) {
        final store = StoreModel.fromJson(storeJson);
        StoreInstances.add(store);
      }
      return StoreInstances;
    }
    throw Error();
  }
}
