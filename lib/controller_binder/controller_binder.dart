
import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/log_in/controller/login_controller.dart';
import 'package:sportyo/feature/authentication/sing_in/controller/create_account.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
  Get.put(LogInController());
  Get.put(CreateAccountController());
  }
}