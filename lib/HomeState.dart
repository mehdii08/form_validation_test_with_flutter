class HomeState {
  const HomeState({
    this.code = '',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  final String code;
  final bool isLoading, isSubmitted;

  bool showErrorMessage() => code.isNotEmpty && !formIsValid;

  bool get formIsValid => code.length == 5;
}
