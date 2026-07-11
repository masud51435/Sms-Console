import '../../../../core/usecases/usecase.dart';
import '../entities/cost_breakdown_entity.dart';
import '../repositories/sms_repository.dart';

class GetCostBreakdownParams {
  final DateTime? from;
  final DateTime? to;

  GetCostBreakdownParams({
    this.from,
    this.to,
  });
}

class GetCostBreakdownUseCase implements UseCase<CostBreakdownEntity, GetCostBreakdownParams> {
  final SmsRepository repository;

  GetCostBreakdownUseCase(this.repository);

  @override
  Future<CostBreakdownEntity> call(GetCostBreakdownParams params) {
    return repository.getCostBreakdown(
      from: params.from,
      to: params.to,
    );
  }
}
