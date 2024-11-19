// To parse this JSON data, do
//
//     final followResponse = followResponseFromJson(jsonString);

import 'dart:convert';

FollowResponse followResponseFromJson(String str) => FollowResponse.fromJson(json.decode(str));

String followResponseToJson(FollowResponse data) => json.encode(data.toJson());

class FollowResponse {
  Followee? followee;

  FollowResponse({
    this.followee,
  });

  factory FollowResponse.fromJson(Map<String, dynamic> json) => FollowResponse(
    followee: json["followee"] == null ? null : Followee.fromJson(json["followee"]),
  );

  Map<String, dynamic> toJson() => {
    "followee": followee?.toJson(),
  };
}

class Followee {
  int? id;
  int? userId;
  int? followeeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Followee({
    this.id,
    this.userId,
    this.followeeId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Followee.fromJson(Map<String, dynamic> json) => Followee(
    id: json["id"],
    userId: json["user_id"],
    followeeId: json["followee_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "followee_id": followeeId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isActive: json["isActive"],
    country: json["country"],
    ip: json["ip"],
    long: json["long"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isActive": isActive,
    "country": country,
    "ip": ip,
    "long": long,
    "lat": lat,
  };
}
