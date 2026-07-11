class SmsMessageEntity {
  final String messageId;
  final String status;
  final String provider;
  final String cost;
  final String currency;

  SmsMessageEntity({
    required this.messageId,
    required this.status,
    required this.provider,
    required this.cost,
    required this.currency,
  });
}
