import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EventController extends GetxController {
  // TextEditingControllers for the text fields
  final TextEditingController searchController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController sportController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController dateFromController = TextEditingController();
  final TextEditingController dateToController = TextEditingController();

  // Observable variables for filters
  var country = ''.obs;
  var sport = ''.obs;
  var event = ''.obs;
  var dateFrom = ''.obs;
  var dateTo = ''.obs;

  // Method to clear all filters
  void clearFilters() {
    countryController.clear();
    sportController.clear();
    eventController.clear();
    dateFromController.clear();
    dateToController.clear();
    country.value = '';
    sport.value = '';
    event.value = '';
    dateFrom.value = '';
    dateTo.value = '';
  }

  // Method to apply the filters and close the dialog
  void applyFilters() {
    country.value = countryController.text;
    sport.value = sportController.text;
    event.value = eventController.text;
    dateFrom.value = dateFromController.text;
    dateTo.value = dateToController.text;
    Get.back(); // Close the dialog
  }

  @override
  void onClose() {
    searchController.dispose();
    countryController.dispose();
    sportController.dispose();
    eventController.dispose();
    dateFromController.dispose();
    dateToController.dispose();
    super.onClose();
  }
}
