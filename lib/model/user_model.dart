class UserModel {
  String id;
  String name;
  String password;
  String mail;
  String image;

  UserModel(
      {required this.id,
      required this.name,
      required this.password,
      required this.mail,
      required this.image});

  UserModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        password = map['password'],
        mail = map['mail'],
        image = map['image'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'mail': mail,
      'image': image,
    };
  }
}
