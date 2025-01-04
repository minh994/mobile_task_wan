import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService extends GetxService {
  final _db = FirebaseFirestore.instance;
  final currentUser = Rxn<UserModel>();

  // Collection reference
  CollectionReference get _usersRef => _db.collection('users');

  Future<void> loadUser(String userId) async {
    try {
      final doc = await _usersRef.doc(userId).get();
      if (doc.exists && doc.data() != null) {
        currentUser.value = UserModel.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }
    } catch (e) {
      throw Exception('Không thể tải thông tin người dùng: $e');
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _usersRef.doc(userId).set(data, SetOptions(merge: true));
      await loadUser(userId);
    } catch (e) {
      throw Exception('Không thể cập nhật thông tin người dùng: $e');
    }
  }
}
