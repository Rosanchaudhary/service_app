class TicketComment {
  String id;
  String ticketId;
  String comment;
  String role;
  String userId;
  String createdAt;
  String userName;

  TicketComment({
   required this.comment,
   required this.createdAt,
   required this.id,
   required this.role,
   required this.ticketId,
   required this.userName,
   required this.userId,
  });
}
