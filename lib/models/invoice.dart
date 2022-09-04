import 'package:flutter/widgets.dart';

class Invoice with ChangeNotifier {
  String id;
  String artistId;
  String invoiceId;
  String bookingId;
  String workingMin;
  String totalAmount;
  String artistAmount;
  String tax;
  String currency;
  String couponCode;
  String paymentStatus;
  String categoryAmount;
  String flag;
  String createdAt;
  String referralAmount;
  String referralPercentage;
  String discountAmount;
  String bookingDate;
  String artistName;
  String categoryName;
  String artistImage;
  String address;
  String finalAmount;

  Invoice({
   required this.address,
   required this.artistAmount,
   required this.artistId,
   required this.artistImage,
   required this.artistName,
   required this.bookingId,
   required this.bookingDate,
   required this.categoryAmount,
   required this.categoryName,
   required this.couponCode,
   required this.createdAt,
   required this.currency,
   required this.discountAmount,
   required this.flag,
   required this.id,
   required this.invoiceId,
   required this.paymentStatus,
   required this.referralAmount,
   required this.referralPercentage,
   required this.tax,
   required this.totalAmount,
   required this.workingMin,
   required this.finalAmount,
  });
}
