enum NameError { empty, invalid, length }

class NameValidator {
  String? _errorMessage = '';
  bool _isValid = false;

  static final RegExp nameRegex = RegExp(r'^[a-zA-Z0-9]+$');

  void validate({String value = ''}) {
    NameError? error = _validator(value);

    if (error != null) {
      if (error == NameError.empty) _errorMessage = 'El campo es requerido';
      if (error == NameError.invalid)
        _errorMessage = 'El nombre es inválido, debe tener letras y/o números';
      if (error == NameError.length)
        _errorMessage = 'El nombre debe tener entre 6 y 20 caracteres';
    } else _errorMessage = null;
  }

  NameError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      _isValid = false;
      return NameError.empty;
    }
    if (!nameRegex.hasMatch(value)) {
      _isValid = false;
      return NameError.invalid;
    }
    if (value.length < 6 || value.length > 20) {
      _isValid = false;
      return NameError.length;
    }
    _isValid = true;
    return null;
  }

  String? get erroMessage => _errorMessage;
  bool get isValid => _isValid;
}
