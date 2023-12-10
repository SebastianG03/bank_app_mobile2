class UserModel {
  final int idUser;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String role;
  final String dni;

  UserModel({
    required this.idUser,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.dni,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["idUser"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
        dni: json["dni"],
      );

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'dni': dni,
    };
  }
}
