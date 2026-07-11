import 'package:get/get.dart';
import '../../../../core/services/tenant_service.dart';
import '../../data/datasources/sms_remote_data_source.dart';
import '../../data/repositories/sms_repository_impl.dart';
import '../../domain/repositories/sms_repository.dart';
import '../../domain/usecases/get_cost_breakdown_usecase.dart';
import '../../domain/usecases/get_sms_history_usecase.dart';
import '../../domain/usecases/send_sms_usecase.dart';
import '../controllers/sms_console_controller.dart';
import '../../../../core/network/api_client.dart';

class SmsConsoleBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Data Sources
    Get.lazyPut<SmsRemoteDataSource>(
      () => SmsRemoteDataSourceImpl(client: Get.find<ApiClient>(tag: 'secure')),
    );

    // 2. Repositories
    Get.lazyPut<SmsRepository>(
      () => SmsRepositoryImpl(remoteDataSource: Get.find()),
    );

    // 3. Use Cases
    Get.lazyPut(() => SendSmsUseCase(Get.find()));
    Get.lazyPut(() => GetCostBreakdownUseCase(Get.find()));
    Get.lazyPut(() => GetSmsHistoryUseCase(Get.find()));

    // 4. Controllers
    Get.lazyPut(
      () => SmsConsoleController(
        sendSmsUseCase: Get.find(),
        getCostBreakdownUseCase: Get.find(),
        getSmsHistoryUseCase: Get.find(),
        tenantService: Get.find<TenantService>(),
      ),
    );
  }
}
