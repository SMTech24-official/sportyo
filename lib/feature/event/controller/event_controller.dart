import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/core/service_class/network_caller/repository/second_network_caller.dart';
import 'package:sportyo/feature/event/model/event_model_class.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class EventController extends GetxController {
  // Observable for storing event data
  final Rx<EventModel> _eventModelList = EventModel().obs;
  Rx<EventModel> get eventModelList => _eventModelList;

  // This list will hold the filtered events
  final RxList<EventList> filteredEventList = <EventList>[].obs;

  // Variables for search and filters
  final TextEditingController searchController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController sportController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController dateFromController = TextEditingController();
  final TextEditingController dateToController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (eventModelList.value.eventList == null ||
        eventModelList.value.eventList!.isEmpty) {
      featchEventData();
    } else {
      // Initialize the filtered list with all events when the controller is initialized
      filteredEventList.value = eventModelList.value.eventList ?? [];
    }

    // Listen to changes in the search field and filter events
    searchController.addListener(() {
      filterEventsByNameOrCity(searchController.text);
    });
  }

  // Method to fetch event data
  Future<void> featchEventData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      final response =
          await SecondNetworkCaller().getRequest(Urls.event, token: token);
      if (response.isSuccess) {
        _eventModelList.value = EventModel.fromJson(response.responseData);
        // Initialize the filtered list with fetched data
        filteredEventList.value = eventModelList.value.eventList ?? [];
      } else {
        EasyLoading.showError('Failed to load data');
      }
    } catch (error) {
      EasyLoading.showError('An error occurred: $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Method to filter events based on search input for event name or city name
  void filterEventsByNameOrCity(String query) {
    if (query.isEmpty) {
      // If the search field is empty, show all events
      filteredEventList.value = eventModelList.value.eventList ?? [];
    } else {
      // Filter events where either the event name or the city contains the query (case insensitive)
      filteredEventList.value = eventModelList.value.eventList
              ?.where((event) =>
                  (event.eventName
                          ?.toLowerCase()
                          .contains(query.toLowerCase()) ??
                      false) ||
                  (event.city?.toLowerCase().contains(query.toLowerCase()) ??
                      false))
              .toList() ??
          [];
    }
  }

// Method to filter events based on the selected country
  Future<void> filterEventByCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      // Construct the URL with the selected country for filtering
      final response = await SecondNetworkCaller().getRequest(
        Urls.filterEventByCountry(countryController.text.trim()),
        token: token,
      );

      // Handle response success
      if (response.isSuccess) {
        // Parse the response data into the EventModel
        EventModel fetchedEventModel =
            EventModel.fromJson(response.responseData);
        // Update the event list with the filtered data from the API
        _eventModelList.value = fetchedEventModel;
        // Update the filteredEventList with the filtered events
        filteredEventList.value = fetchedEventModel.eventList ?? [];
        Get.back(); // Close any open dialogs or pages if needed
      } else {
        EasyLoading.showError('No participants present at this time.');
      }
    } catch (error) {
      EasyLoading.showError('Failed to search event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> filterEventBySport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      // Construct the URL with the selected country for filtering
      final response = await SecondNetworkCaller().getRequest(
        Urls.filterEventBySport(
            countryController.text.trim(), sportController.text.trim()),
        token: token,
      );
      // Handle response success
      if (response.isSuccess) {
        // Parse the response data into the EventModel
        EventModel fetchedEventModel =
            EventModel.fromJson(response.responseData);
        // Update the event list with the filtered data from the API
        _eventModelList.value = fetchedEventModel;
        // Update the filteredEventList with the filtered events
        filteredEventList.value = fetchedEventModel.eventList ?? [];
        Get.back(); // Close any open dialogs or pages if needed
      } else {
        EasyLoading.showError('No participants present at this time.');
      }
    } catch (error) {
      EasyLoading.showError('Failed to search event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> filterEventByLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      // Construct the URL with the selected country for filtering
      final response = await SecondNetworkCaller().getRequest(
        Urls.filterEventByLevel(countryController.text.trim(),
            sportController.text.trim(), eventController.text.trim()),
        token: token,
      );
      // Handle response success
      if (response.isSuccess) {
        // Parse the response data into the EventModel
        EventModel fetchedEventModel =
            EventModel.fromJson(response.responseData);
        // Update the event list with the filtered data from the API
        _eventModelList.value = fetchedEventModel;
        // Update the filteredEventList with the filtered events
        filteredEventList.value = fetchedEventModel.eventList ?? [];
        Get.back(); // Close any open dialogs or pages if needed
      } else {
        EasyLoading.showError('No participants present at this time.');
      }
    } catch (error) {
      EasyLoading.showError('Failed to search event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> filterEventByDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      // Construct the URL with the selected country for filtering
      final response = await SecondNetworkCaller().getRequest(
        Urls.filterEventByDate(
            countryController.text.trim(),
            sportController.text.trim(),
            eventController.text.trim(),
            dateFromController.text.trim(),
            dateToController.text.trim()),
        token: token,
      );
      // Handle response success
      if (response.isSuccess) {
        // Parse the response data into the EventModel
        EventModel fetchedEventModel =
            EventModel.fromJson(response.responseData);
        // Update the event list with the filtered data from the API
        _eventModelList.value = fetchedEventModel;
        // Update the filteredEventList with the filtered events
        filteredEventList.value = fetchedEventModel.eventList ?? [];
        Get.back(); // Close any open dialogs or pages if needed
      } else {
        EasyLoading.showError('No participants present at this time.');
      }
    } catch (error) {
      EasyLoading.showError('Failed to search event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Clear the search input
  void clearSearch() {
    searchController.clear();
  }

  // Filter fields
  var country = ''.obs;
  var sport = ''.obs;
  var event = ''.obs;
  var dateFrom = ''.obs;
  var dateTo = ''.obs;
// Country list
  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Côte d\'Ivoire',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Democratic Republic of the Congo',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Holy See',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine State',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States of America',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];
  // Apply filters
  void applyFilters() {
    country.value = countryController.text;
    sport.value = sportController.text;
    event.value = eventController.text;
    dateFrom.value = dateFromController.text;
    dateTo.value = dateToController.text;
    Get.back(); // Close the dialog
  }

  // Clear filters
  void clearFilters() {
    countryController.clear();
    sportController.clear();
    eventController.clear();
    dateFromController.clear();
    dateToController.clear();
  }
}
