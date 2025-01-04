import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/i_verification_repository.dart';

class VerificationRepository implements IVerificationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> sendVerificationEmail(String email) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user found');
      }

      await user.sendEmailVerification();
    } catch (e) {
      throw Exception('Failed to send verification email: ${e.toString()}');
    }
  }

  @override
  Future<bool> checkEmailVerified() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user found');
      }

      await user.reload();
      return user.emailVerified;
    } catch (e) {
      throw Exception('Failed to check email verification: ${e.toString()}');
    }
  }
} 