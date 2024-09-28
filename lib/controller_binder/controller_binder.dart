import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/log_in/controller/login_controller.dart';
import 'package:sportyo/feature/authentication/sing_in/controller/create_account.dart';
import 'package:sportyo/feature/event/controller/event_controller.dart';
import 'package:sportyo/feature/splash_screen/controller/splash_screen_controller.dart';

import '../feature/event/controller/event_name_controller.dart';
import '../feature/event/controller/find_partners_for_event_controller.dart';
import '../feature/terms_and_condition/controller/terms_and_condition.dart';

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
    Get.lazyPut<FindPartnersForEventController>(
      () => FindPartnersForEventController(),
      fenix: true,
    );
    Get.lazyPut<SplashController>(
          () => SplashController(),
      fenix: true,
    );
    Get.lazyPut<TermsAndConditionController>(
          () => TermsAndConditionController(),
      fenix: true,
    );
  }
}
