class Ticket {
  String id;
  String userId;
  String reason;
  String description;
  String status;
  String createdAt;

  Ticket({
   required this.createdAt,
   required this.description,
   required this.id,
   required this.reason,
   required this.status,
   required this.userId,
  });
}
