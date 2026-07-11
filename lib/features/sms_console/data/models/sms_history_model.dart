import '../../domain/entities/sms_history_entity.dart';

class SmsHistoryResponseModel {
  final List<SmsHistoryItemModel> items;
  final String? nextCursor;

  SmsHistoryResponseModel({
    required this.items,
    this.nextCursor,
  });

  factory SmsHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return SmsHistoryResponseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => SmsHistoryItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
    );
  }
}

class SmsHistoryItemModel {
  final String messageId;
  final String recipient;
  final String status;
  final int segmentCount;
  final String cost;
  final DateTime sentAt;

  SmsHistoryItemModel({
    required this.messageId,
    required this.recipient,
    required this.status,
    required this.segmentCount,
    required this.cost,
    required this.sentAt,
  });

  factory SmsHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return SmsHistoryItemModel(
      messageId: json['messageId'] as String,
      recipient: json['recipient'] as String,
      status: json['status'] as String,
      segmentCount: json['segmentCount'] as int,
      cost: json['cost'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
    );
  }

  SmsHistoryItemEntity toEntity() {
    return SmsHistoryItemEntity(
      messageId: messageId,
      recipient: recipient,
      status: status,
      segmentCount: segmentCount,
      cost: cost,
      sentAt: sentAt,
    );
  }
}
