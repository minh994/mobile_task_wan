class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String occupation;
  final String location;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.occupation,
    required this.location,
  });

  factory UserModel.fromFirestore(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      occupation: data['occupation'] ?? '',
      location: data['location'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'occupation': occupation,
      'location': location,
    };
  }
}
