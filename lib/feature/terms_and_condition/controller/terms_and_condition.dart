import 'package:get/get.dart';

class TermsAndConditionController extends GetxController{
 RxBool isAccept =false.obs;

 void acceptButton(){
  isAccept.value=true;
  Get.back();
 }
}