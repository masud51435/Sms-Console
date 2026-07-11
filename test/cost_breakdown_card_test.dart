import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sms_console/features/sms_console/domain/entities/cost_breakdown_entity.dart';
import 'package:sms_console/features/sms_console/presentation/controllers/sms_console_controller.dart';
import 'package:sms_console/features/sms_console/presentation/widgets/cost_breakdown_card.dart';

class MockSmsConsoleController extends GetxController implements SmsConsoleController {
  @override final costBreakdown = Rxn<CostBreakdownEntity>();
  @override final costBreakdownError = RxnString();
  
  @override
  Future<void> fetchCostBreakdown() async {}
  
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('CostBreakdownCard should display data correctly', (WidgetTester tester) async {
    final controller = MockSmsConsoleController();
    controller.costBreakdown.value = CostBreakdownEntity(
      currency: 'EUR',
      totalCost: '12.4500',
      rows: [
        CostRowEntity(provider: 'TWILIO', totalCost: '8.2500', messageCount: 110),
        CostRowEntity(provider: 'AWS_SNS', totalCost: '4.2000', messageCount: 91),
      ],
    );
    
    Get.put<SmsConsoleController>(controller);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: CostBreakdownCard(),
          ),
        ),
      ),
    );

    expect(find.text('Cost Breakdown'), findsOneWidget);
    expect(find.text('EUR 12.4500'), findsOneWidget);
    expect(find.text('TWILIO'), findsOneWidget);
    expect(find.text('AWS_SNS'), findsOneWidget);
    expect(find.text('110 messages'), findsOneWidget);
    expect(find.text('EUR 8.2500'), findsOneWidget);
  });
}
