class Gallery {
  String? original;
  String? thumbnail;
  String? medium;

  Gallery({this.original, this.thumbnail, this.medium});

  Gallery.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    thumbnail = json['thumbnail'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    return data;
  }


}
