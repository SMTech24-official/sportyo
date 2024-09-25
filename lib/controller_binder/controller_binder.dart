import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/log_in/controller/login_controller.dart';
import 'package:sportyo/feature/authentication/sing_in/controller/create_account.dart';
import 'package:sportyo/feature/event/controller/event_controller.dart';

import '../feature/event/controller/event_name_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInController>(
      () => LogInController(),
      fenix: true,
    );
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(),
      fenix: true,
    );
    Get.lazyPut<EventController>(
      () => EventController(),
      fenix: true,
    );

    Get.lazyPut<EventNameController>(
      () => EventNameController(),
      fenix: true,
    );
  }
}
