import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final HomeRepository repository = HomeRepositoryImpl();

  AuthBloc() : super(AuthInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// Handles the [LogoutRequested] event.
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(LogoutInProgress());
    try {
      await repository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
