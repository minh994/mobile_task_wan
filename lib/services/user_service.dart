import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/models/user.dart';

class UserService extends GetxService {
  final _db = FirebaseFirestore.instance;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  Future<UserModel> loadUser(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        final user = UserModel.fromMap(doc.data()!);
        currentUser.value = user;
        return user;
      }
      throw Exception('Không thể tải thông tin người dùng');
    } catch (e) {
      throw Exception('Không thể tải thông tin người dùng: $e');
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);
      await loadUser(uid); // Reload user data after update
    } catch (e) {
      throw Exception('Cập nhật thông tin thất bại: $e');
    }
  }
}
