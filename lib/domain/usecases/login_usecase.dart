import '../entities/user_entity.dart';
import '../../data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<void> login(UserEntity user) async {
    await _authRepository.signIn(user.email, user.password);
  }
}
