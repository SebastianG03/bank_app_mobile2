enum DniError { empty, invalid, length }

class DniValidator {
  String? _errorMessage = '';
  bool _isValid = false;

  static final RegExp dniRegex = RegExp(r'^\d+$');

  void validate({String value = ''}) {
    DniError? error = _validator(value);

    if (error != null) {
      if (error == DniError.empty) _errorMessage = 'El campo es requerido';
      if (error == DniError.invalid)
        _errorMessage = 'La cédula no es válida, debe tener solo números';
      if (error == DniError.length)
        _errorMessage = 'La cédula debe tener 10 números';
    } else
      _errorMessage = null;
  }

  DniError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      _isValid = false;
      return DniError.empty;
    }
    if (!dniRegex.hasMatch(value)) {
      _isValid = false;
      return DniError.invalid;
    }
    if (value.length != 10) {
      _isValid = false;
      return DniError.length;
    }
    _isValid = true;
    return null;
  }

  String? get erroMessage => _errorMessage;
  bool get isValid => _isValid;
}
