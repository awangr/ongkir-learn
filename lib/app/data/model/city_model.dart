class City {
  String? cityId;
  String? provId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;
  City(this.cityId, this.provId, this.province, this.type, this.cityName,
      this.postalCode);
  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }

  static List<City> fromJsonList(List list) {
    if (list.length == 0) return List<City>.empty();
    return list.map((e) => City.fromJson(e)).toList();
  }
}
