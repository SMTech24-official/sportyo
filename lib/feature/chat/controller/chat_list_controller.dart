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

  // Polling timer
  Timer? _timer;

  // @override
  // void donInit() {
  //   super.onInit();
  //   startPolling();
  // }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Start polling every 2 seconds
  void startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await fetchChatUsers();
    });
  }

  // Fetch chat users from API
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
          var users = (jsonData['data'] as List)
              .map((user) => ChatUser.fromJson(user))
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
