import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/services/user_service.dart';

class AuthService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _userService = Get.find<UserService>();

  // Stream để lắng nghe trạng thái authentication
  Stream<User?> get userStream => _auth.authStateChanges();

  // Getter để lấy user hiện tại
  User? get currentUser => _auth.currentUser;

  // Đăng nhập với email và password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kiểm tra xác thực email
      if (!userCredential.user!.emailVerified) {
        throw Exception('Email chưa được xác thực. Vui lòng xác thực email trước khi đăng nhập.');
      }

      return userCredential;
    } catch (e) {
      throw Exception('Đăng nhập thất bại: $e');
    }
  }

  // Đăng ký với email và password
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Gửi email xác thực
      await userCredential.user?.sendEmailVerification();

      // Tạo document user trong Firestore
      if (userCredential.user != null) {
        final newUser = UserModel(
          id: userCredential.user!.uid,
          name: 'User',
          email: email,
          photoUrl: '',
          occupation: 'Not set',
          location: 'Not set',
        );

        await _userService.updateUser(newUser.id, newUser.toFirestore());
      }

      return userCredential;
    } catch (e) {
      throw Exception('Đăng ký thất bại: $e');
    }
  }

  // Đăng nhập với Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Đăng nhập Google bị hủy');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Tạo/Cập nhật user document
      final user = userCredential.user!;
      final newUser = UserModel(
        id: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
        occupation: 'Not set',
        location: 'Not set',
      );
      await _userService.updateUser(newUser.id, newUser.toFirestore());

      return userCredential;
    } catch (e) {
      throw Exception('Đăng nhập Google thất bại: $e');
    }
  }

  // Kiểm tra trạng thái xác thực email
  Future<bool> checkEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e) {
      throw Exception('Không thể kiểm tra trạng thái xác thực: $e');
    }
  }

  // Gửi lại email xác thực
  Future<void> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Không tìm thấy người dùng');
      }
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception('Không thể gửi lại email xác thực: $e');
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Đăng xuất thất bại: $e');
    }
  }
}
