import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Singleton instance
  static final SecureStorageService _instance =
  SecureStorageService._internal();

  // Private constructor
  SecureStorageService._internal();

  // Factory constructor
  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Write value
  Future<void> write(String key, String value) async {
    print("Local Storage Write - Key $key - $value");
    await _storage.write(key: key, value: value);
  }

  /// Read value
  Future<String?> read(String key) async {
    print("Local Storage Read - Key $key");
    return await _storage.read(key: key);
  }

  /// Delete one key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
