import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/core/service_class/network_caller/utility/usrls.dart';
import '../model/chat_list_model.dart';

class ChatsListController extends GetxController {
  var chatUsers = <ChatUser>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchChatUsers();
    super.onInit();
  }

  // Fetch the chat users from the API
  Future<void> fetchChatUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    final url = '${Urls.baseUrl}/chat/$userId/chatUsers';
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          var users = (jsonData['data'] as List)
              .map((user) => ChatUser.fromJson(user))
              .toList();
          users.sort((a, b) {
            if (a.createdAt == null && b.createdAt == null) return 0;
            if (a.createdAt == null) return 1;
            if (b.createdAt == null) return -1;
            return b.createdAt!.compareTo(a.createdAt!);
          });

          chatUsers.value = users;
        }
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
