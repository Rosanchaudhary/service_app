class Booking {
  String id;
  String userImage;
  String userName;
  String bookingTime;
  String bookingDate;
  String description;
  String address;
  String flag;
  String startTime;

  Booking({
   required this.address,
   required this.bookingDate,
   required this.bookingTime,
   required this.description,
   required this.flag,
   required this.id,
   required this.userImage,
   required this.userName,
   required this.startTime,
  });
}
