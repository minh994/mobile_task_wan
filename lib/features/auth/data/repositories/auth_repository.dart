import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../../home/data/repositories/user_repository.dart';
import '../../../home/domain/models/user.dart' as app_user;

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    signInOption: SignInOption.standard,
  );
  final UserRepository _userRepository = UserRepository();

  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      // Force show account picker
      await _googleSignIn.signOut();
      
      // Trigger Google Sign In with account picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Get auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      
      if (user != null) {
        // Create/Update user document
        final newUser = app_user.User(
          id: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          occupation: 'Not set',
          location: 'Not set',
        );
        
        await _userRepository.updateUser(newUser);
      }

      return user;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
} 