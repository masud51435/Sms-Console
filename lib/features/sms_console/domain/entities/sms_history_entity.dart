class SmsHistoryItemEntity {
  final String messageId;
  final String recipient;
  final String status;
  final int segmentCount;
  final String cost;
  final DateTime sentAt;

  SmsHistoryItemEntity({
    required this.messageId,
    required this.recipient,
    required this.status,
    required this.segmentCount,
    required this.cost,
    required this.sentAt,
  });
}
