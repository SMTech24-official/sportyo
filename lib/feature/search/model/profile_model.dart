class UserModel {
  String id;
  String email;
  String? userProfileImage;
  String? firstName;
  String? lastName;
  String gender;
  String dateOfBirth;
  String bio;
  String language;
  bool incognito;
  bool genderRestriction;
  String role;
  String userStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<SportsDetail> sportsDetails;

  UserModel({
    required this.id,
    required this.email,
    this.userProfileImage,
    this.firstName,
    this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.language,
    required this.incognito,
    required this.genderRestriction,
    required this.role,
    required this.userStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.sportsDetails,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      userProfileImage: json['userProfileImage'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      bio: json['bio'] ?? '',
      language: json['language'] ?? '',
      incognito: json['incognito'] ?? false,
      genderRestriction: json['genderRestriction'] ?? false,
      role: json['role'] ?? '',
      userStatus: json['userStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      sportsDetails: (json['SportsDetails'] as List)
          .map((item) => SportsDetail.fromJson(item))
          .toList(),
    );
  }
}

class SportsDetail {
  String id;
  String sportsName;
  String level;

  SportsDetail({
    required this.id,
    required this.sportsName,
    required this.level,
  });

  factory SportsDetail.fromJson(Map<String, dynamic> json) {
    return SportsDetail(
      id: json['id'] ?? '',
      sportsName: json['sportsName'] ?? '',
      level: json['level'] ?? '',
    );
  }
}
