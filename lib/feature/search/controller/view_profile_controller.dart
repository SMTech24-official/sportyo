import 'package:get/get.dart';
import 'package:sportyo/feature/chat/screen/chats_screen.dart';

class PrpfoleDetailsController extends GetxController {
  var sports = [
    {"sport": "Football", "level": "Beginner"},
    {"sport": "Basketball", "level": "Intermediate"},
    {"sport": "Tennis", "level": "Advanced"},
  ].obs;

  var languages = ["English", "Spanish", "French"].obs;

  var upcomingEvents = ["Event 1", "Event 2", "Event 3"].obs;

  void startChat() {
    Get.to(
      () => ChatScreen(
        name: "Tom",
        image:
            "https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg",
        chatId: "5665569584784",
      ),
    );
  }
}
