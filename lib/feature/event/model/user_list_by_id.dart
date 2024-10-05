class UserListByEventId {
  bool? success;
  String? message;
  List<Data>? data;

  UserListByEventId({this.success, this.message, this.data});

  UserListByEventId.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? userId;
  String? userProfileImage;
  String? firstName;
  String? lastName;
  String? joinedAt;

  Data(
      {this.userId,
        this.userProfileImage,
        this.firstName,
        this.lastName,
        this.joinedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userProfileImage = json['userProfileImage'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    joinedAt = json['joinedAt'];
  }


}
