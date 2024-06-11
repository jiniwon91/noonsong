import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunsong/services/map_api.dart';

class ApiService {
  static const baseurl =
      'https://ctrtk2ywofaktzy4susqp3s4u40udnlf.lambda-url.us-east-1.on.aws';

  static Future<MapModel> fetchDatafromAPI(String pname) async {
    final url = Uri.parse('$baseurl/?pname=$pname');
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
