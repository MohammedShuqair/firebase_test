class UserModel {
  String id;
  String? email;
  String? name;

  UserModel({
    required this.id,
    this.email,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
          {required String uid}) =>
      UserModel(
        id: uid,
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
