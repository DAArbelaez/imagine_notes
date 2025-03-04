import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository = HomeRepositoryImpl();

  HomeBloc() : super(HomeInitial()) {
    on<HomeLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(HomeLogoutRequested event, Emitter<HomeState> emit) async {
    emit(HomeLogoutInProgress());
    try {
      await repository.logout();
      emit(HomeLogoutSuccess());
    } catch (e) {
      emit(HomeLogoutFailure(e.toString()));
    }
  }
}
