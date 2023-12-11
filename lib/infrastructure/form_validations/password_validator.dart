enum PasswordError { empty, invalid, length }

class PasswordValidator {
  String? _errorMessage = '';
  bool _isValid = false;

  static final RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  void validate({String value = ''}) {
    PasswordError? error = _validator(value);

    if (error != null) {
      if (error == PasswordError.empty) _errorMessage = 'El campo es requerido';
      if (error == PasswordError.length) {
        _errorMessage = 'La contraseña debe tener entre 8 y 20 caracteres';
      }
    } else {
      _errorMessage = null;
    }
  }

  PasswordError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      _isValid = false;
      return PasswordError.empty;
    }
    if (value.length < 8 || value.length > 20) {
      _isValid = false;
      return PasswordError.length;
    }
    _isValid = true;
    return null;
  }

  String? get erroMessage => _errorMessage;
  bool get isValid => _isValid;
}
