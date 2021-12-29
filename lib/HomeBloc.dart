import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeEvent.dart';
import 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<CodeChanged>(_onCodeChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onCodeChanged(CodeChanged event, Emitter<HomeState> emit) {
    emit(HomeState(code: event.code));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<HomeState> emit) async {
    if (state.formIsValid) {
      emit(const HomeState(isLoading: true));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const HomeState(isLoading: false, isSubmitted: true));
    }
  }
}
