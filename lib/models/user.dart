class User {
  final String uuid;
  final String image;
  final String name;
  final String email;
  final String phone;
  final String? gender;
  final String? birthday;
  final String type;
  final String role;
  final String status;

  User({
    required this.uuid,
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    this.gender,
    this.birthday,
    required this.type,
    required this.role,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      image: json['image'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      type: json['type'],
      role: json['role'],
      status: json['status'],
    );
  }
} 