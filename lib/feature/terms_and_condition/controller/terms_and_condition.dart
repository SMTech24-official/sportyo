import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';
import '../model/termsAndPolicy.dart';

class TermsAndConditionController extends GetxController {
  RxBool isAccept = false.obs;

  void acceptButton() {
    isAccept.value = true;
    Get.back();
  }

  final Rx<TermsAndPolicy> _termsAndPolicy = TermsAndPolicy().obs;
  Rx<TermsAndPolicy> get termsAndPolicy => _termsAndPolicy;

  Future<void> fetchTermsData() async {
    EasyLoading.show(status: "Loading...");
    try {
      final response = await NetworkCaller().getRequest(Urls.termsAndPolicy);

      if (response.isSuccess) {

        if (response.responseData is List &&
            (response.responseData as List).isNotEmpty) {
          // Access the first element of the data list
          final data = (response.responseData as List)[0];

          // Check if the required fields are present in the data
          if (data is Map && data.containsKey('id') && data.containsKey('policy') && data.containsKey('termsConditions')) {
            // Cast to Map<String, dynamic>
            final termsMap = data as Map<String, dynamic>;

            // Deserialize into your model class
            _termsAndPolicy.value = TermsAndPolicy.fromJson(termsMap);
          } else {
            EasyLoading.showError('Data format is incorrect.');
          }
        } else {
          EasyLoading.showError('No policies found or data is not in expected format.');
        }
      } else {
        EasyLoading.showError('Failed to load data: ${response.errorMessage}');
      }
    } catch (error) {
      print('An error occurred: $error');
      EasyLoading.showError('An error occurred: $error');
    } finally {
      EasyLoading.dismiss();
    }
  }



}


