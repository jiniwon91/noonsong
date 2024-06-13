class StoreModel {
  final String name, address, google_maps_link;
  final double latitude, longitude;
  final double? rating;

  StoreModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        latitude = double.parse(json['latitude'].toString()),
        longitude = double.parse(json['longitude'].toString()),
        address = json['address'],
        rating =
            json['rating'] is int ? json['rating'].toDouble() : json['rating'],
        google_maps_link = json['google_maps_link'];
}
