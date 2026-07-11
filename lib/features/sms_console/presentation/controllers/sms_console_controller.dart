import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/tenant_service.dart';
import '../../domain/entities/cost_breakdown_entity.dart';
import '../../domain/entities/sms_history_entity.dart';
import '../../domain/usecases/get_cost_breakdown_usecase.dart';
import '../../domain/usecases/get_sms_history_usecase.dart';
import '../../domain/usecases/send_sms_usecase.dart';
import '../../../../core/utils/snackbar/toast_service.dart';

class SmsConsoleController extends GetxController {
  final SendSmsUseCase sendSmsUseCase;
  final GetCostBreakdownUseCase getCostBreakdownUseCase;
  final GetSmsHistoryUseCase getSmsHistoryUseCase;
  final TenantService tenantService;

  SmsConsoleController({
    required this.sendSmsUseCase,
    required this.getCostBreakdownUseCase,
    required this.getSmsHistoryUseCase,
    required this.tenantService,
  });

  final phoneController = TextEditingController();
  final bodyController = TextEditingController();
  late final TextEditingController tenantController;

  final isLoading = false.obs;
  final isHistoryLoading = false.obs;
  final isSending = false.obs;

  final costBreakdown = Rxn<CostBreakdownEntity>();
  final costBreakdownError = RxnString();
  final historyItems = <SmsHistoryItemEntity>[].obs;
  final historyError = RxnString();
  final nextCursor = RxnString();

  @override
  void onInit() {
    super.onInit();
    tenantController = TextEditingController(text: tenantService.activeTenantId);
    refreshAll();
  }

  Future<void> refreshAll() async {
    isLoading.value = true;
    costBreakdownError.value = null;
    historyError.value = null;
    try {
      await Future.wait([
        fetchCostBreakdown(),
        fetchHistory(refresh: true),
      ]);
    } catch (e) {
      // Handled by interceptor
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCostBreakdown() async {
    try {
      costBreakdownError.value = null;
      final data = await getCostBreakdownUseCase(GetCostBreakdownParams());
      costBreakdown.value = data;
    } catch (e) {
      costBreakdownError.value = e.toString();
      rethrow;
    }
  }

  Future<void> fetchHistory({bool refresh = false}) async {
    if (refresh) {
      nextCursor.value = null;
      historyItems.clear();
      historyError.value = null;
    }

    if (isHistoryLoading.value) return;

    isHistoryLoading.value = true;
    try {
      final (items, cursor) = await getSmsHistoryUseCase(
        GetSmsHistoryParams(cursor: nextCursor.value),
      );
      historyItems.addAll(items);
      nextCursor.value = cursor;
    } catch (e) {
      historyError.value = e.toString();
      rethrow;
    } finally {
      isHistoryLoading.value = false;
    }
  }

  Future<void> sendSms() async {
    if (phoneController.text.isEmpty || bodyController.text.isEmpty) {
      ToastService.showError('Please fill in all fields');
      return;
    }

    isSending.value = true;
    try {
      await sendSmsUseCase(
        SendSmsParams(
          to: phoneController.text,
          body: bodyController.text,
        ),
      );
      ToastService.showSuccess('SMS sent successfully');
      phoneController.clear();
      bodyController.clear();
      refreshAll();
    } catch (e) {
      // Handled by interceptor
    } finally {
      isSending.value = false;
    }
  }

  void switchTenant(String newTenantId) {
    tenantService.setTenantId(newTenantId);
    tenantController.text = newTenantId;
    refreshAll();
  }

  @override
  void onClose() {
    phoneController.dispose();
    bodyController.dispose();
    tenantController.dispose();
    super.onClose();
  }
}
