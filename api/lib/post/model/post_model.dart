class User {
  final int? id;
  final String? name;
  final String? email;

  User({this.id, this.name, this.email, String? title, String? body});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
