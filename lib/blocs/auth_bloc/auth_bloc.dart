import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_health_app/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthState()) {
    on<SignInRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
        rethrow;
      }
    }));
    on<SignUpRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
        rethrow;
      }
    }));
    on<GoogleSignInRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.sigInWithGoogle();
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
        rethrow;
      }
    }));
    on<SignOutRequested>(((event, emit) async {
      emit(AuthLoadingState());
      await authRepository.signOut();
      emit(UnAuthState());
    }));
  }
}
