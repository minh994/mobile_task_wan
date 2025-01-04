import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/user.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> updateUser(User user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toMap(), SetOptions(merge: true));
      print('User updated successfully: ${user.name}'); // Debug print
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Failed to update user: $e');
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) {
        print('User document not found for ID: $userId'); // Debug print
        return null;
      }
      
      final data = doc.data()!;
      data['id'] = doc.id; // Ensure ID is included
      final user = User.fromMap(data);
      print('Retrieved user: ${user.name}'); // Debug print
      return user;
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Failed to get user: $e');
    }
  }
} 