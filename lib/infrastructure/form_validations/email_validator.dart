enum EmailError { empty, invalid }

class EmailValidator {
  String? _errorMessage = '';
  bool _isValid = false;

  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void validate({String value = ''}) {
    EmailError? error = _validator(value);

    if (error != null) {
      if (error == EmailError.empty) _errorMessage = 'El campo es requerido';
      if (error == EmailError.invalid) _errorMessage = 'El correo no es válido';
    } else _errorMessage = null;
  }

  EmailError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      _isValid = false;
      return EmailError.empty;
    }
    if (!emailRegex.hasMatch(value)) {
      _isValid = false;
      return EmailError.invalid;
    }
    _isValid = true;
    return null;
  }

  String? get erroMessage => _errorMessage;
  bool get isValid => _isValid;
}
