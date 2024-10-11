import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../profile/widget/global_text_style.dart';
import '../controller/chat_controller.dart';
import 'delete_chat_dialouge.dart';
import 'report_user_dialouge.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String image;
  final ChatsController chatsController;

  const CustomAppBar({
    super.key,
    required this.name,
    required this.image,
    required this.chatsController,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0), // Custom height
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              CircleAvatar(
                backgroundImage: image.isEmpty
                    ? const AssetImage(ImagePath.profile)
                    : NetworkImage(image),
                radius: 20,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Obx(() {
                        return chatsController.isTyping.value
                            ? const Row(
                                children: [
                                  Text(
                                    'Typing...',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      }),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      deleteChatDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'Delete chat',
                        style: globalTextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      reportUserDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'Report',
                        style: globalTextStyle(
                            fontSize: 12, color: AppColors.redcolor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(80.0); // Custom app bar height
}
