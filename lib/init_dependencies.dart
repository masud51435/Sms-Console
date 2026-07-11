import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'core/storage/local_storage.dart';

/// Initialize global dependencies
Future<void> initDependencies() async {
  await Hive.initFlutter();
  
  final prefs = await SharedPreferences.getInstance();
  Get.put(LocalStorage(prefs), permanent: true);
}
