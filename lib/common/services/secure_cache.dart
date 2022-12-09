import 'package:flutter_secure_storage/flutter_secure_storage.dart';


mixin SecureStorageMixin {
  static const String _authTokenKey = '_auth_token_key';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<String?> _read(String key) async {
    return await _storage.read(key: key);
  }

  Future<Map<String, String>> _readAll() async {
    return await _storage.readAll();
  }

  Future<void> _delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> _deleteAll() async {
    await _storage.deleteAll();
  }

  Future<void> _write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Use this method to securely save auth token
  Future<void> writeAuthToken(String value) async {
    await _write(_authTokenKey, value);
  }

  Future<String?> readAuthToken() async {
    return await _read(_authTokenKey);
  }
}
