import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeEvent.dart';
import 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<InitialEvent>(_onInitialEvent);
    on<CodeChanged>(_onCodeChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onInitialEvent(InitialEvent event, Emitter<HomeState> emit) {
    emit(const HomeState());
  }

  void _onCodeChanged(CodeChanged event, Emitter<HomeState> emit) {
    emit(HomeState(code: event.code));
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<HomeState> emit) async {
    if (event.code.length != 5) {
      emit(const HomeState(formIsValid: false));
    } else {
      emit(const HomeState(isLoading: true));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(HomeState(isLoading: false, formIsValid: state.validateForm(event.code)));
    }
  }
}
