import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/region_model.dart';
import 'package:safqa_app/data/models/user_model.dart';

import 'gallery_model.dart';

class PostModel {
  int? id;
  String? title;
  String? description;
  int? price;
  bool? isPremium;
  String? createdAt;
  String? updatedAt;
  List<Gallery>? gallery;
  List<String>? meta;
  User? user;
  CategoryModel? category;
  Region? region;
  Region? city;
  Region? district;
  List<String>? latestActivePackage;
  bool? activePackagesExists;
  int? packagesCount;
  int? followersCount;
  int? favoritersCount;
  int? commentsCount;

  PostModel(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.isPremium,
        this.createdAt,
        this.updatedAt,
        this.gallery,
        this.meta,
        this.user,
        this.category,
        this.region,
        this.city,
        this.district,
        this.latestActivePackage,
        this.activePackagesExists,
        this.packagesCount,
        this.followersCount,
        this.favoritersCount,
        this.commentsCount});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    isPremium = json['is_premium'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add( Gallery.fromJson(v));
      });
    }
    if (json['meta'] != null) {
      meta = <String>[];
      json['meta'].forEach((v) {
        meta!.add( v);
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    city = json['city'] != null ? new Region.fromJson(json['city']) : null;
    district =
    json['district'] != null ? new Region.fromJson(json['district']) : null;
    if (json['latest_active_package'] != null) {
      latestActivePackage = <String>[];
      json['latest_active_package'].forEach((v) {
        latestActivePackage!.add(v);
      });
    }
    activePackagesExists = json['active_packages_exists'];
    packagesCount = json['packages_count'];
    followersCount = json['followers_count'];
    favoritersCount = json['favoriters_count'];
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_premium'] = this.isPremium;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.map((v) => v).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.latestActivePackage != null) {
      data['latest_active_package'] =
          this.latestActivePackage!.map((v) => v).toList();
    }
    data['active_packages_exists'] = this.activePackagesExists;
    data['packages_count'] = this.packagesCount;
    data['followers_count'] = this.followersCount;
    data['favoriters_count'] = this.favoritersCount;
    data['comments_count'] = this.commentsCount;
    return data;
  }


  String parseDate(DateTime date){
    DateTime now= DateTime.now();
    int diffrenceInDays= now.difference(date).inDays;
    return '${diffrenceInDays} ايام';
  }

  List<String> galleryToStringList(){
    return gallery!.map(
      (e) => e.original!,
    ).toList();
  }
}

