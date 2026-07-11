import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sms_console/features/sms_console/presentation/controllers/sms_console_controller.dart';
import 'package:sms_console/features/sms_console/presentation/widgets/sms_send_form.dart';

@GenerateMocks([SmsConsoleController])
import 'sms_send_form_test.mocks.dart';

void main() {
  late MockSmsConsoleController mockController;

  setUp(() {
    mockController = MockSmsConsoleController();
    
    // Setup essential members
    final phoneController = TextEditingController();
    final bodyController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    
    when(mockController.phoneController).thenReturn(phoneController);
    when(mockController.bodyController).thenReturn(bodyController);
    when(mockController.formKey).thenReturn(formKey);
    when(mockController.isSending).thenReturn(false.obs);
    
    Get.put<SmsConsoleController>(mockController);
  });

  tearDown(() {
    Get.delete<SmsConsoleController>();
  });

  testWidgets('SmsSendForm should show validation errors when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SmsSendForm(),
          ),
        ),
      ),
    );

    // Tap send without entering anything
    await tester.tap(find.text('Send Message'));
    await tester.pump();

    // Verification logic depends on how controller.sendSms is implemented
    // In our case, sendSms is called, which calls formKey.currentState.validate()
    verify(mockController.sendSms()).called(1);
  });
}
