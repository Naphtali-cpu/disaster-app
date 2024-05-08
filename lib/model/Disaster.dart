class Disaster {
  final String id;
  final String name;

  Disaster({required this.id, required this.name});

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      id: json['id'],
      name: json['name'],
    );
  }
}