enum AmountError { empty, format }

class AmountValidator {
  String? _errorMessage = '';

  static final RegExp dniRegex = RegExp(r'^\d+(\.\d{1,2})?$');

  void validate({String value = ''}) {
    AmountError? error = _validator(value);

    if (error != null) {
      if (error == AmountError.empty) _errorMessage = 'El campo es requerido';
      if (error == AmountError.format)_errorMessage = 'El campo solo admite números (0.00).';
    } else _errorMessage = null;
  }

  AmountError? _validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AmountError.empty;
    if (!dniRegex.hasMatch(value)) return AmountError.format;
     return null;
  }

  String? get erroMessage => _errorMessage;
}
