import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_data.dart';

const String authPersistKey = 'authPersistData';

class AuthPersistData {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> setAuthData(AuthData authData) async {
    await _secureStorage.write(
      key: authPersistKey,
      value: jsonEncode(authData.toJson()),
    );
  }

  Future<AuthData> getAuthData() async {
    String? authDataJson = await _secureStorage.read(key: authPersistKey);

    if (authDataJson == null) throw Exception('Not authenticated');
    return AuthData.fromJson(jsonDecode(authDataJson));
  }

  Future<void> deleteAuthData() async {
    await _secureStorage.delete(key: authPersistKey);
  }
}
