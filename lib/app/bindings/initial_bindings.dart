import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/links.dart';
import '../../core/services/tenant_service.dart';
import '../../core/services/theme_service.dart';
import '../../core/storage/auth_persist_data.dart';
import '../../core/storage/local_storage.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // 1. Core Services
    Get.lazyPut(() => ThemeService(Get.find<LocalStorage>()), fenix: true);
    Get.put(TenantService());
    Get.lazyPut(() => AuthPersistData(), fenix: true);

    // 2. Api Clients
    Get.lazyPut<ApiClient>(
      () => DioClient(baseUrl: Links.baseUrl, tag: 'Public API'),
      tag: 'public',
      fenix: true,
    );

    Get.lazyPut<ApiClient>(
      () => DioClient(
        baseUrl: Links.baseUrl,
        tag: 'Secure API',
        tokenProvider: () async {
          // In a real app, this would come from secure storage
          // For this assignment, we use the hardcoded key from the contract if not set
          return 'fw_live_8c21e0b47ad94f13ba77e0c9d51a3b62';
        },
        tenantIdProvider: () async => Get.find<TenantService>().activeTenantId,
      ),
      tag: 'secure',
      fenix: true,
    );
  }
}
