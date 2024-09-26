class SportsDetail {
  String? id;
  String? userId;
  String? sportsName;
  String? level;
  DateTime? createdAt;
  DateTime? updatedAt;

  SportsDetail({
    this.id,
    this.userId,
    this.sportsName,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  factory SportsDetail.fromJson(Map<String, dynamic> json) {
    return SportsDetail(
      id: json['id'],
      userId: json['userId'],
      sportsName: json['sportsName'],
      level: json['level'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sportsName': sportsName,
      'level': level,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
