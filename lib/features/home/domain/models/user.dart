class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String occupation;
  final String location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.occupation,
    required this.location,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      occupation: map['occupation'] as String,
      location: map['location'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'occupation': occupation,
      'location': location,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? occupation,
    String? location,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      occupation: occupation ?? this.occupation,
      location: location ?? this.location,
    );
  }
} 