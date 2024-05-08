class UserModel{
  int id;
  String name,email,role,created_at;

  UserModel(this.id, this.name, this.email, this.role, this.created_at);

  UserModel.fromJson(Map<String, dynamic> json): id = json['id'],name = json['name'],email = json['email'],role = json['role'],created_at = json['created_at'];

}