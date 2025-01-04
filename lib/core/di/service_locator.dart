import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/i_auth_repository.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/services/verification_service.dart';
import '../../features/auth/services/login_service.dart';
import '../../features/home/data/repositories/task_repository.dart';
import '../../features/home/data/repositories/user_repository.dart';
import '../../features/home/services/task_service.dart';
import '../../features/home/services/user_service.dart';
import '../../features/auth/data/repositories/verification_repository.dart';
import '../../features/auth/domain/repositories/i_verification_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(),
  );
  
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(),
  );

  getIt.registerLazySingleton<IVerificationRepository>(
    () => VerificationRepository(),
  );

  // Services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      getIt<IAuthRepository>(),
      getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<LoginService>(
    () => LoginService(getIt<IAuthRepository>()),
  );

  getIt.registerLazySingleton<VerificationService>(
    () => VerificationService(getIt<IVerificationRepository>()),
  );
  
  getIt.registerLazySingleton<UserService>(
    () => UserService(getIt<UserRepository>()),
  );

  getIt.registerLazySingleton<TaskService>(
    () => TaskService(getIt<TaskRepository>()),
  );
} 