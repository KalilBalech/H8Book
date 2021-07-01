import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LowerCaseText extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldText, TextEditingValue newText){
      return newText.copyWith(text: newText.text.toLowerCase());
    }
}

class UpperCaseText extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldText, TextEditingValue newText){
      return newText.copyWith(text: newText.text.toUpperCase());
    }
}