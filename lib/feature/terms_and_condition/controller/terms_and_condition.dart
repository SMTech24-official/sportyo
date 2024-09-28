import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class TermsAndConditionController extends GetxController {
  RxBool isAccept = false.obs;

  void acceptButton() {
    isAccept.value = true;
    Get.back();
  }

  Future<void> featchTermsData() async {
    EasyLoading.show(status: "Loading...");
    try {
      final response = await NetworkCaller().getRequest(Urls.sendEmail);

      if (response.isSuccess) {
      } else {
        EasyLoading.showError('Failed to load data');
      }
    } catch (error) {
      EasyLoading.showError('An error occurred: $error');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
