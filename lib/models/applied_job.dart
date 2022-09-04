import 'package:flutter/cupertino.dart';

class AppliedJob with ChangeNotifier {
  String id;
  String userId;
  String artistId;
  String jobId;
  String price;
  String description;
  String status;
  String createdAt;
  String updatedAt;
  String currencySymbol;
  String categoryName;
  String userName;
  String userImage;
  String userAddress;
  String title;
  String jobDate;
  String time;
  String jobTimestamp;
  String userMobile;
  String userEemail;
  int rate;

  AppliedJob({
   required this.artistId,
   required this.categoryName,
   required this.createdAt,
   required this.currencySymbol,
   required this.description,
   required this.id,
   required this.jobDate,
   required this.jobId,
   required this.jobTimestamp,
   required this.price,
   required this.status,
   required this.time,
   required this.title,
   required this.updatedAt,
   required this.userAddress,
   required this.userEemail,
   required this.userId,
   required this.userImage,
   required this.userMobile,
   required this.userName,
   required this.rate,
  });
}
