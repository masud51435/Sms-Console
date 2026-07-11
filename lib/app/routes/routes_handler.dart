import 'package:get/get.dart';
import '../routes/routes.dart';
import '../routes/routes_config.dart';
import '../../features/sms_console/presentation/bindings/sms_console_binding.dart';

List<GetPage> routesHandler = [
  GetPage(
    name: BaseRoute.smsConsole,
    page: () => RoutesConfig.smsConsole,
    binding: SmsConsoleBinding(),
    transition: Transition.fadeIn,
  ),
];
