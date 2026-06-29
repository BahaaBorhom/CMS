class Clinic {
  final String id;
  final String name;
  final String specialty;
  final String location;
  final String hours;
  final double latitude;
  final double longitude;
  final double rating;
  final bool isSaved;
  final String imageUrl;

  Clinic({
    required this.id,
    required this.name,
    required this.specialty,
    required this.location,
    required this.hours,
    required this.latitude,
    required this.longitude,
    this.rating = 4.5,
    this.isSaved = false,
    this.imageUrl = '',
  });

  // Factory to create from JSON (for API later)
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      location: json['location'],
      hours: json['hours'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      rating: json['rating'] ?? 4.5,
      isSaved: json['isSaved'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'location': location,
      'hours': hours,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'isSaved': isSaved,
      'imageUrl': imageUrl,
    };
  }
}