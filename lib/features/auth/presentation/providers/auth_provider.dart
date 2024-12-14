import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/repository/auth_repository_infrastructure.dart';

// 1-Construim l'estat a controlar i proveir

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// 2- Construim el notificador, que defineixi en quins moments
// i per quines situacions hem de notificar els nous estat
// i després el provider

// Notificador
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryDomain authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());
  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error d\'accès no controlat');
    }
  }

  registerUser(String email, String password, String fullName) async {}

  checkAuthStatus() async {}

  _setLoggedUser(User user) async {
    // TODO: Cal guardar TOKEN físicament
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // TODO: Netejar TOKEN
    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage ?? '',
    );
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // Ara si, el provider utilitza el auth_repositori_infrastructure.dart
  // per a cridar tots els metodes d'autetificacio creat
  // Per tant, creem una instancia d'AuthRepositoryInfrastructure
  final authRepository = AuthRepositoryInfrastructure();
  return AuthNotifier(authRepository: authRepository);
});
