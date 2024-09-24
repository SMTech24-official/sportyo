import 'package:get/get.dart';

class EventNameController extends GetxController{
  RxBool isValidate=false.obs;
  @override
  void onClose() {
    isValidate.value = false;
    super.onClose();
  }
}