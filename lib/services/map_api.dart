class MapModel {
  final String location, CONGEST_LVL, CONGEST_MSG, PPLTN_TIME, SKY_STTS;
  final int PPLTN_MIN, PPLTN_MAX;
  final double TEMP;

  MapModel.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        CONGEST_LVL = json['AREA_CONGEST_LVL'],
        CONGEST_MSG = json['AREA_CONGEST_MSG'],
        PPLTN_MIN = int.parse(json['AREA_PPLTN_MIN'].toString()),
        PPLTN_MAX = int.parse(json['AREA_PPLTN_MAX'].toString()),
        PPLTN_TIME = json['PPLTN_TIME'],
        TEMP = double.parse(json['TEMP'].toString()),
        SKY_STTS = json['SKY_STTS'];
}
