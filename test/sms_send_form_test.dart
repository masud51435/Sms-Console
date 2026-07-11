import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sms_console/features/sms_console/presentation/controllers/sms_console_controller.dart';
import 'package:sms_console/features/sms_console/presentation/widgets/sms_send_form.dart';

class MockSmsConsoleController extends GetxController implements SmsConsoleController {
  @override final phoneController = TextEditingController();
  @override final bodyController = TextEditingController();
  @override final formKey = GlobalKey<FormState>();
  @override final isSending = false.obs;

  bool sendSmsCalled = false;

  @override
  Future<void> sendSms() async {
    sendSmsCalled = true;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockSmsConsoleController mockController;

  setUp(() {
    mockController = MockSmsConsoleController();
    Get.put<SmsConsoleController>(mockController);
  });

  tearDown(() {
    Get.delete<SmsConsoleController>();
  });

  testWidgets('SmsSendForm should trigger sendSms on button tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: SmsSendForm()),
          ),
        ),
      ),
    );

    // Verify fields exist
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Recipient Phone'), findsOneWidget);
    expect(find.text('Message Body'), findsOneWidget);

    // Tap send
    await tester.tap(find.text('Send Message'));
    await tester.pump();

    expect(mockController.sendSmsCalled, isTrue);
  });
}
