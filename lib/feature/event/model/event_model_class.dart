class EventModel {
  bool? success;
  String? message;
  List<EventList>? eventList;

  EventModel({this.success, this.message, this.eventList});

  EventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      eventList = <EventList>[];
      json['data'].forEach((v) {
        eventList!.add(EventList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (eventList != null) {
      data['data'] = eventList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventList {
  String? id;
  String? sport;
  String? eventImage;
  String? eventName;
  String? city;
  String? country;
  String? date;
  dynamic distance;
  String? label;
  String? link;
  String? description;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  EventList(
      {this.id,
        this.sport,
        this.eventImage,
        this.eventName,
        this.city,
        this.country,
        this.date,
        this.distance,
        this.label,
        this.link,
        this.description,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  EventList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sport = json['sport'];
    eventImage = json['eventImage'];
    eventName = json['eventName'];
    city = json['city'];
    country = json['country'];
    date = json['date'];
    distance = json['distance'];
    label = json['label'];
    link = json['link'];
    description = json['description'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sport'] = sport;
    data['eventImage'] = eventImage;
    data['eventName'] = eventName;
    data['city'] = city;
    data['country'] = country;
    data['date'] = date;
    data['distance'] = distance;
    data['label'] = label;
    data['link'] = link;
    data['description'] = description;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
