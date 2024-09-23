import 'package:get/get.dart';

class ChatsController extends GetxController {
  var chats = <Chat>[
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you? ca we talk . i want to go an event',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
    Chat(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727049600&semt=ais_hybrid',
      name: 'John Doe',
      lastMessage: 'Hey, how are you?',
    ),
    Chat(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmIVL39xwKm42kJS3b3F_aI7WhosNdC7rrWXIeX74C98ibrQT91M1nxiFgjyfX1XBIB0&usqp=CAU',
      name: 'Jane Smith',
      lastMessage: 'See you tomorrow!',
    ),
  ].obs;
}

class Chat {
  final String imageUrl;
  final String name;
  final String lastMessage;

  Chat({required this.imageUrl, required this.name, required this.lastMessage});
}
