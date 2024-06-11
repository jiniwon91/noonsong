class MapModel {
  final String location, CONGEST_LVL, CONGEST_MSG, PPLTN_TIME, PCP_MSG;
  final int PPLTN_MIN, PPLTN_MAX;
  final double TEMP;
  MapModel.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        CONGEST_LVL = json['CONGEST_LVL'],
        CONGEST_MSG = json['CONGEST_MSG'],
        PPLTN_MIN = json['PPLTN_MIN'],
        PPLTN_MAX = json['PPLTN_MAX'],
        PPLTN_TIME = json['PPLTN_TIME'],
        TEMP = json['TEMP'],
        PCP_MSG = json['PCP_MSG'];
}
