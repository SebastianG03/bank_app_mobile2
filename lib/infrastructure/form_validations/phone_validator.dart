enum PhoneError { empty, invalid, length }

class PhoneValidator {
  String? _errorMessage = '';
  bool _isValid = false;

  static final RegExp phoneRegex = RegExp(r'^\d+$');

  void validate({String value = ''}) {
    PhoneError? error = _validator(value);

    if (error != null) {
      if (error == PhoneError.empty) _errorMessage = 'El campo es requerido';
      if (error == PhoneError.invalid)
        _errorMessage = 'Formato inválido. Solo ingrese números';
      if (error == PhoneError.length)
        _errorMessage = 'El número debe estar conformado de 9 digitos';
    } else
      _errorMessage = null;
  }

  PhoneError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      _isValid = false;
      return PhoneError.empty;
    }
    if (!phoneRegex.hasMatch(value)) {
      _isValid = false;
      return PhoneError.invalid;
    }
    if (value.length != 9) {
      _isValid = false;
      return PhoneError.length;
    }
    _isValid = true;
    return null;
  }

  String? get erroMessage => _errorMessage;
  bool get isValid => _isValid;
}
