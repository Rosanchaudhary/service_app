import 'package:flutter/cupertino.dart';

class Artist with ChangeNotifier {
  String id;
  String userId;
  String name;
  String categoryId;
  String description;
  String aboutUs;
  String skills;
  String image;
  String completionRate;
  String createdAt;
  String updatedAt;
  String bio;
  String longitude;
  String latitude;
  String location;
  String videoUrl;
  String price;
  String bookingFlag;
  String isOnline;
  String gender;
  String preference;
  String updateProfile;
  int total;
  int percentages;
  int jobDone;
  String categoryName;
  String categoryPrice;
  String distance;
  int avaRating;
  String favStatus;
  String featured;
  String commissionType;
  String flatType;
  String artistCommissionType;
  String currencyType;
  String bannerImage;
  String liveLat;
  String liveLong;
  String city;
  String country;
  List<Map<String, dynamic>> qualifications;
  List<Map<String, dynamic>> artistBooking;
  List<Map<String, dynamic>> products;
  List<Map<String, dynamic>> reviews;
  List<Map<String, dynamic>> gallery;

  Artist({
  required  this.aboutUs,
  required  this.artistCommissionType,
  required  this.avaRating,
  required  this.bannerImage,
  required  this.bio,
  required  this.bookingFlag,
  required  this.categoryId,
  required  this.categoryName,
  required  this.categoryPrice,
  required  this.commissionType,
  required  this.completionRate,
  required  this.createdAt,
  required  this.currencyType,
  required  this.description,
  required  this.distance,
  required  this.favStatus,
  required  this.featured,
  required  this.flatType,
  required  this.gender,
  required  this.id,
  required  this.image,
  required  this.isOnline,
  required  this.jobDone,
  required  this.latitude,
  required  this.location,
  required  this.longitude,
  required  this.name,
  required  this.percentages,
  required  this.preference,
  required  this.price,
  required  this.skills,
  required  this.total,
  required  this.updateProfile,
  required  this.updatedAt,
  required  this.userId,
  required  this.videoUrl,
  required  this.city,
  required  this.country,
  required  this.liveLat,
  required  this.liveLong,
  required  this.artistBooking,
  required  this.gallery,
  required  this.products,
  required  this.qualifications,
  required  this.reviews,
  });
}
