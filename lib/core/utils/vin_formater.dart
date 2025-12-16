import 'package:flutter/services.dart';

class VinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleanedText = newValue.text.toUpperCase().replaceAll(
          RegExp(r'[^A-HJ-NPR-Z0-9]'),
          '',
        );

    final truncatedText = cleanedText.length > 17 
        ? cleanedText.substring(0, 17) 
        : cleanedText;

    return TextEditingValue(
      text: truncatedText,
      selection: TextSelection.collapsed(
        offset: truncatedText.length,
      ),
    );
  }
}