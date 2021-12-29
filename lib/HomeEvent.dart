

class HomeEvent {
  const HomeEvent();

}

class InitialEvent extends HomeEvent{

}

class CodeChanged extends HomeEvent{
  CodeChanged({required this.code});

  String code;
}

class FormSubmitted extends HomeEvent{
  FormSubmitted({required this.code});

  String code;
}
