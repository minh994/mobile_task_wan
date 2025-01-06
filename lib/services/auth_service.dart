import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();
  final currentUser = Rxn<User>();
  final isLoggedIn = false.obs;
  final currentUserModel = Rxn<UserModel>();
  StreamSubscription? _userSubscription;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
      _listenToUserProfile(currentUser.value!.uid);
      print('Auth state changed: ${user?.email}');
    });
  }

  void _listenToUserProfile(String userId) {
    _userSubscription?.cancel();
    _userSubscription = _db.collection('users').doc(userId).snapshots().listen(
      (doc) {
        if (doc.exists && doc.data() != null) {
          currentUserModel.value = UserModel.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        } else {
          currentUser.value = null;
        }
      },
      onError: (error) {
        print('Error listening to user profile: $error');
      },
    );
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(userId).set(
            data,
            SetOptions(merge: true),
          );
      _listenToUserProfile(userId);
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Không thể cập nhật thông tin người dùng: $e');
    }
  }

  @override
  void onClose() {
    _userSubscription?.cancel();
    super.onClose();
  }

  // Kiểm tra auth state
  bool get isAuthenticated => currentUser.value != null;

  // Kiểm tra token
  Future<bool> validateToken() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final idToken = await user.getIdToken();
        return idToken != null;
      }
      return false;
    } catch (e) {
      print('Error validating token: $e');
      return false;
    }
  }

  // Check if user is already logged in
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool('isLoggedIn') ?? false;
    if (isLogged) {
      final user = _auth.currentUser;
      if (user != null) {
        currentUser.value = user;
        isLoggedIn.value = true;
      }
    }
  }

  // Update login status in SharedPreferences
  Future<void> _updateLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateLoginStatus(true);
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Create user with email and password
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await _updateLoginStatus(true);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      await _updateLoginStatus(false);
      currentUser.value = null;
      isLoggedIn.value = false;
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear();
      });
    } catch (e) {
      rethrow;
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<bool> checkEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e) {
      print('Error checking email verification: $e');
      return false;
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw Exception('Could not send verification email: $e');
    }
  }
}
