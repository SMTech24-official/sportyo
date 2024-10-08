import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';
import 'package:sportyo/feature/home/screen/home.dart';
import '../../authentication/auth_service/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 1)); // Splash delay
    bool hasToken = await AuthService.hasToken(); // Checking token logic

    if (hasToken) {
      Get.offAll(() => Home());
    } else {
      Get.offAll(() => const LogIn());
    }
  }
}
