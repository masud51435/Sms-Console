import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_bindings.dart';
import 'app/routes/routes.dart';
import 'app/routes/routes_handler.dart';
import 'app/theme/app_theme.dart';
import 'core/storage/local_storage.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global dependencies
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<LocalStorage>();
    final isDarkMode = storage.read('isDarkMode') == 'true';

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'SMS Console',
          debugShowCheckedModeBanner: false,

          // Global Bindings
          initialBinding: InitialBindings(),

          // Routing
          initialRoute: BaseRoute.initial,
          getPages: routesHandler,

          // Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
