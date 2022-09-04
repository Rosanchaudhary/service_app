import 'package:flutter/widgets.dart';

class User with ChangeNotifier implements Iterable {
  String id;
  String name;
  String email;
  String image;
  String address; 
  String officeAddress;
  String liveLat;
  String liveLong;
  String createdAt;
  String mobile;
  String refCode;
  String gender;
  String city;
  String country;
  String updatedAt;
  String deviceType;
  String deviceId;
  String deviceToken;
  String lat;
  String long;
  String iCardImage;
  bool isCustomer;

  User({
      required this.address,
     required this.city,
     required this.country,
     required this.createdAt,
     required this.deviceId,
     required this.deviceToken,
     required this.deviceType,
     required this.email,
     required this.gender,
     required this.iCardImage,
     required this.id,
     required this.image,
     required this.mobile,
     required this.long,
     required this.lat,
     required this.liveLat,
     required this.liveLong,
     required this.name,
     required this.officeAddress,
     required this.refCode,
     required this.updatedAt,
     required this.isCustomer});

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
