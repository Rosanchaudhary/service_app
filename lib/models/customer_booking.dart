import 'package:flutter/widgets.dart';

class CustomerBooking with ChangeNotifier {
  String id;
  String artistName;
  String artistImage;
  String categoryName;
  String price;
  String bookingDate; 
  String bookingTime;
  String artistLocation;
  String description;
  String currencyType;
  String status;
  String bookingFlag;
  String bookingType;
  int jobDone;
  int completePercentages;
  Map<String, String> invoice = {};

  CustomerBooking({
   required this.artistImage,
   required this.artistLocation,
   required this.artistName,
   required this.bookingDate,
   required this.bookingFlag,
   required this.bookingTime,
   required this.categoryName,
   required this.completePercentages,
   required this.currencyType,
   required this.description,
   required this.id,
   required this.jobDone,
   required this.price,
   required this.status,
   required this.bookingType,
   required this.invoice,
  });
}
