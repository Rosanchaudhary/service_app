class WalletHistory {
  String id;
  String description;
  String amount;
  String invoiceId;
  String currency;
  String type;
  String status;
  String orderId;
  String createdAt;

  WalletHistory({
   required this.amount,
   required this.createdAt,
   required this.currency,
   required this.description,
   required this.id,
   required this.invoiceId,
   required this.orderId,
   required this.status,
   required this.type,
  });
}
