class HomeEvent {}

class CodeChanged extends HomeEvent {
  CodeChanged({required this.code});

  String code;
}

class FormSubmitted extends HomeEvent {}
