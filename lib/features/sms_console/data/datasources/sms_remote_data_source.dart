import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/cost_breakdown_model.dart';
import '../models/sms_history_model.dart';
import '../models/sms_message_model.dart';

abstract class SmsRemoteDataSource {
  Future<SmsMessageModel> sendSms({
    required String to,
    required String body,
    String? referenceId,
  });

  Future<CostBreakdownModel> getCostBreakdown({
    String? from,
    String? to,
  });

  Future<SmsHistoryResponseModel> getMessageHistory({
    String? cursor,
    int limit = 50,
  });
}

class SmsRemoteDataSourceImpl implements SmsRemoteDataSource {
  final ApiClient client;

  SmsRemoteDataSourceImpl({required this.client});

  @override
  Future<SmsMessageModel> sendSms({
    required String to,
    required String body,
    String? referenceId,
  }) async {
    return client.request(
      path: '/sms/send',
      method: MethodType.post,
      payload: {
        'to': to,
        'body': body,
        if (referenceId != null) 'referenceId': referenceId,
      },
      parse: (json) => SmsMessageModel.fromJson(json),
    );
  }

  @override
  Future<CostBreakdownModel> getCostBreakdown({
    String? from,
    String? to,
  }) async {
    return client.request(
      path: '/sms/cost/breakdown',
      method: MethodType.get,
      queryParams: {
        if (from != null) 'from': from,
        if (to != null) 'to': to,
      },
      parse: (json) => CostBreakdownModel.fromJson(json),
    );
  }

  @override
  Future<SmsHistoryResponseModel> getMessageHistory({
    String? cursor,
    int limit = 50,
  }) async {
    return client.request(
      path: '/sms/messages',
      method: MethodType.get,
      queryParams: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
      parse: (json) => SmsHistoryResponseModel.fromJson(json),
    );
  }
}
