class UserModel {
  String id;
  String? email;
  String? name;
  int? age;
  bool? isGraduated;

  UserModel({
    required this.id,
    this.email,
    this.name,
    this.age,
    this.isGraduated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
          {required String uid}) =>
      UserModel(
        id: uid,
        email: json["email"],
        name: json["name"],
        age: json["age"],
        isGraduated: json["is_graduated"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "age": age,
        "is_graduated": isGraduated,
      };
}
