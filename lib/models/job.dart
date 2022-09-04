import 'package:flutter/cupertino.dart';

class Job with ChangeNotifier {
  String id;
  String userId;
  String jobId;
  String title;
  String description;
  String categoryId;
  String status;
  String avtar;
  String address;
  String price;
  String lati;
  String longi;
  String jobDate;
  String time;
  String jobTimestamp;
  String createdAt;
  String updatedAt;
  int isEdit;
  String categoryName;
  int appliedJob;
  String currencySymbol;
  String categoryPrice;

  Job({
   required this.address,
   required this.appliedJob,
   required this.avtar,
   required this.categoryId,
   required this.categoryName,
   required this.categoryPrice,
   required this.createdAt,
   required this.currencySymbol,
   required this.description,
   required this.id,
   required this.isEdit,
   required this.jobDate,
   required this.jobId,
   required this.jobTimestamp,
   required this.lati,
   required this.time,
   required this.longi,
   required this.price,
   required this.status,
   required this.title,
   required this.updatedAt,
  required this.userId,
  });
}
