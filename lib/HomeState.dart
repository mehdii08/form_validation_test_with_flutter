import 'FormStatus.dart';

class HomeState {
  const HomeState({this.code = '', this.formIsValid = false, this.isLoading = false});

  final String code;
  final bool formIsValid;
  final bool isLoading;

  bool showErrorMessage() => code.isEmpty || code.length == 5;

  bool validateForm(String code) => code.length == 5;
}
