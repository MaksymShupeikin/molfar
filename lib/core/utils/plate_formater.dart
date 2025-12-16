import 'package:flutter/services.dart';

class PlateInputFormatter extends TextInputFormatter {
  final RegExp _isDigitRegex = RegExp(r'[0-9]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleanedText = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-ZА-ЯІЇЄҐЁ0-9]'),
      '',
    );

    if (cleanedText.length <
        oldValue.text.replaceAll(' ', '').length) {
      return newValue.copyWith(
        text: cleanedText,
        selection: TextSelection.collapsed(
          offset: cleanedText.length,
        ),
      );
    }

    final buffer = StringBuffer();

    for (int i = 0; i < cleanedText.length; i++) {
      final char = cleanedText[i];
      bool isValidForPosition = false;

      if (i < 2) {
        if (!_isDigitRegex.hasMatch(char)) isValidForPosition = true;
      } else if (i < 6) {
        if (_isDigitRegex.hasMatch(char)) isValidForPosition = true;
      } else if (i < 8) {
        if (!_isDigitRegex.hasMatch(char)) isValidForPosition = true;
      } else {
        break;
      }

      if (!isValidForPosition) {
        final currentBuffer = buffer.toString();
        return TextEditingValue(
          text: currentBuffer,
          selection: TextSelection.collapsed(
            offset: currentBuffer.length,
          ),
        );
      }

      if (i == 2) buffer.write(' ');
      if (i == 6) buffer.write(' ');

      buffer.write(char);
    }

    final formattedText = buffer.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      ),
    );
  }
}
