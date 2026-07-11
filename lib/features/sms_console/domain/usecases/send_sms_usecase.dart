import '../../../../core/usecases/usecase.dart';
import '../entities/sms_message_entity.dart';
import '../repositories/sms_repository.dart';

class SendSmsParams {
  final String to;
  final String body;
  final String? referenceId;

  SendSmsParams({
    required this.to,
    required this.body,
    this.referenceId,
  });
}

class SendSmsUseCase implements UseCase<SmsMessageEntity, SendSmsParams> {
  final SmsRepository repository;

  SendSmsUseCase(this.repository);

  @override
  Future<SmsMessageEntity> call(SendSmsParams params) {
    return repository.sendSms(
      to: params.to,
      body: params.body,
      referenceId: params.referenceId,
    );
  }
}
