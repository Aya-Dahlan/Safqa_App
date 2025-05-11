class User {
  int? id;
  String? name;
  List<String>? avatarUrls;
  String? type;

  User({this.id, this.name, this.avatarUrls, this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['avatar_urls'] != null) {
      avatarUrls = <String>[];
      json['avatar_urls'].forEach((v) {
        avatarUrls!.add(v);
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.avatarUrls != null) {
      data['avatar_urls'] = this.avatarUrls!.map((v) => v).toList();
    }
    data['type'] = this.type;
    return data;
  }
}