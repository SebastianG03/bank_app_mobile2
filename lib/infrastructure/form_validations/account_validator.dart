enum AccountError { empty, format }

class AccountValidator {
  String? _errorMessage = '';

  static final RegExp dniRegex = RegExp(r'^\d+$');

  void validate({String value = ''}) {
    AccountError? error = _validator(value);

    if (error != null) {
      if (error == AccountError.empty) _errorMessage = 'El campo es requerido';
      if (error == AccountError.format)
        _errorMessage = 'El campo solo admite números';
    } else
      _errorMessage = null;
  }

  AccountError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AccountError.empty;
    if (!dniRegex.hasMatch(value)) return AccountError.format;
    return null;
  }

  String? get erroMessage => _errorMessage;
}
