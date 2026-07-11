import '../../domain/entities/sms_message_entity.dart';

class SmsMessageModel {
  final String messageId;
  final String provider;
  final String status;
  final int segmentCount;
  final String cost;
  final String currency;

  SmsMessageModel({
    required this.messageId,
    required this.provider,
    required this.status,
    required this.segmentCount,
    required this.cost,
    required this.currency,
  });

  factory SmsMessageModel.fromJson(Map<String, dynamic> json) {
    return SmsMessageModel(
      messageId: json['messageId'] as String,
      provider: json['provider'] as String,
      status: json['status'] as String,
      segmentCount: json['segmentCount'] as int,
      cost: json['cost'] as String,
      currency: json['currency'] as String,
    );
  }

  SmsMessageEntity toEntity() {
    return SmsMessageEntity(
      messageId: messageId,
      status: status,
      provider: provider,
      cost: cost,
      currency: currency,
    );
  }
}
