import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _completedPagesKey = 'completed_pages';
  static const String _userNameKey = 'user_name';

  static Future<int> getCompletedPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_completedPagesKey) ?? 0;
  }

  static Future<void> saveCompletedPages(int pages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_completedPagesKey, pages);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  static Future<void> resetProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_completedPagesKey, 0);
  }
}
