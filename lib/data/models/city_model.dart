class CityModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? latitude;
  String? longitude;
  bool? isSelected=false;

  CityModel({this.id, this.nameAr, this.nameEn, this.latitude, this.longitude,this.isSelected});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
