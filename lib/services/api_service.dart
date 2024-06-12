import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunsong/services/map_api.dart';

class ApiService {
  static const baseurl_place =
      'https://ubunj66fwhu2yktk4tw4noo77e0fvmrb.lambda-url.ap-northeast-2.on.aws';

  static Future<MapModel> fetchDatafromAPI(String pname) async {
    final url = Uri.parse('$baseurl_place/?pname=$pname');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responseBody =
          const Utf8Decoder().convert(response.bodyBytes);
      final Map<String, dynamic> mapinfo = jsonDecode(responseBody);
      mapinfo['location'] = pname;
      print(mapinfo);
      return MapModel.fromJson(mapinfo);
    } else {
      throw Exception('Failed to load map data');
    }
  }
}
