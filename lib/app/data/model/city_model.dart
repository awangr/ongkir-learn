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
    cityId = json['cityId'];
    provId = json['provId'];
    province = json['province'];
    type = json['type'];
    cityName = json['cityName'];
    postalCode = json['postalCode'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cityId'] = cityId;
    data['provId'] = provId;
    data['province'] = province;
    data['type'] = type;
    data['cityName'] = cityName;
    data['postalCode'] = postalCode;
    return data;
  }

  static List<City> fromJsonList(List list) {
    if (list.length == 0) return List<City>.empty();
    return list.map((e) => City.fromJson(e)).toList();
  }
}
