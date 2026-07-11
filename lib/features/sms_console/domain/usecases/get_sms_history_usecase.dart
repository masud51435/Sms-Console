import '../../../../core/usecases/usecase.dart';
import '../entities/sms_history_entity.dart';
import '../repositories/sms_repository.dart';

class GetSmsHistoryParams {
  final String? cursor;
  final int limit;

  GetSmsHistoryParams({
    this.cursor,
    this.limit = 50,
  });
}

class GetSmsHistoryUseCase implements UseCase<(List<SmsHistoryItemEntity> items, String? nextCursor), GetSmsHistoryParams> {
  final SmsRepository repository;

  GetSmsHistoryUseCase(this.repository);

  @override
  Future<(List<SmsHistoryItemEntity> items, String? nextCursor)> call(GetSmsHistoryParams params) {
    return repository.getMessageHistory(
      cursor: params.cursor,
      limit: params.limit,
    );
  }
}
