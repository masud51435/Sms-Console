import 'package:intl/intl.dart';
import '../../domain/entities/cost_breakdown_entity.dart';
import '../../domain/entities/sms_history_entity.dart';
import '../../domain/entities/sms_message_entity.dart';
import '../../domain/repositories/sms_repository.dart';
import '../datasources/sms_remote_data_source.dart';

class SmsRepositoryImpl implements SmsRepository {
  final SmsRemoteDataSource remoteDataSource;

  SmsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SmsMessageEntity> sendSms({
    required String to,
    required String body,
    String? referenceId,
  }) async {
    final model = await remoteDataSource.sendSms(
      to: to,
      body: body,
      referenceId: referenceId,
    );
    return model.toEntity();
  }

  @override
  Future<CostBreakdownEntity> getCostBreakdown({
    DateTime? from,
    DateTime? to,
  }) async {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    final model = await remoteDataSource.getCostBreakdown(
      from: from != null ? formatter.format(from.toUtc()) : null,
      to: to != null ? formatter.format(to.toUtc()) : null,
    );
    return model.toEntity();
  }

  @override
  Future<(List<SmsHistoryItemEntity> items, String? nextCursor)> getMessageHistory({
    String? cursor,
    int limit = 50,
  }) async {
    final responseModel = await remoteDataSource.getMessageHistory(
      cursor: cursor,
      limit: limit,
    );
    
    return (
      responseModel.items.map((e) => e.toEntity()).toList(),
      responseModel.nextCursor
    );
  }
}
