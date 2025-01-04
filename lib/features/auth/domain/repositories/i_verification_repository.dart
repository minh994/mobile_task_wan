abstract class IVerificationRepository {
  Future<void> sendVerificationEmail(String email);
  Future<bool> checkEmailVerified();
} 