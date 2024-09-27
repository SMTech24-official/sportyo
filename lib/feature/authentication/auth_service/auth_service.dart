import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String tokenKey='token';
  static const String id='userId';
  // Check if a token exists in local storage
  static Future<bool> hasToken() async {
   SharedPreferences preferences=await SharedPreferences.getInstance();
   String? token =preferences.getString(tokenKey);
    return token != null;
  }

  // Save the token to local storage
  static Future<void> saveToken(String token,String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(id, id);
  }


  // Remove the token from local storage (for logout)
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
