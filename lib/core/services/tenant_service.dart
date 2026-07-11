import 'package:get/get.dart';

class TenantService extends GetxService {
  final _activeTenantId = '9f1c2d3e-4a5b-6c7d-8e9f-0a1b2c3d4e5f'.obs;

  String get activeTenantId => _activeTenantId.value;

  void setTenantId(String id) {
    _activeTenantId.value = id;
  }
}
