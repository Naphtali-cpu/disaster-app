class Report {
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;

  Report({required this.description, required this.imageUrl, required this.latitude, required this.longitude});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      description: json['description'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}