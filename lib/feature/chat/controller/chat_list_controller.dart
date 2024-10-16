import 'dart:async';
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
  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Start polling data from API every second
  void startPolling() {
    _timer?.cancel(); // Ensure no duplicate timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await fetchChatUsers();
    });
  }

  // Stop polling data
  void stopPolling() {
    _timer?.cancel();
  }

  Future<void> fetchChatUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    final url = '${Urls.baseUrl}/chat/$userId/chatUsers';
    try {
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          // Filter users where firstName is not null and not empty
          var users = (jsonData['data'] as List)
              .map((user) => ChatUser.fromJson(user))
              .where((user) => user.firstName.isNotEmpty)
              .toList();

          users.sort((a, b) {
            if (a.createdAt == null && b.createdAt == null) return 0;
            if (a.createdAt == null) return 1;
            if (b.createdAt == null) return -1;
            return b.createdAt!.compareTo(a.createdAt!);
          });

          if (!listEquals(chatUsers, users)) {
            chatUsers.assignAll(users);
          }
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
