import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';

class AuthService {
  static const String tokenKey = 'token';
  static const String idKey = 'userId';
  // Check if a token exists in local storage
  static Future<bool> hasToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(tokenKey);
    return token != null;
  }

  // Save the token to local storage
  static Future<void> saveToken(String token, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(idKey, id);
  }

  // Remove the token from local storage (for logout)
  static Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(idKey);
    await prefs.setBool("profileComplete", false);
    Get.offAll(() => const LogIn());
  }

  static Future<bool> profileComplete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? token = preferences.getBool("profileComplete");
    return token != false;
  }
}
