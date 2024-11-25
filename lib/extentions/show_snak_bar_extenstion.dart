import 'package:flutter/material.dart';

extension ShowSnakBarExtenstion on BuildContext {
  void showSnackBar(String message, {bool isError = true}) async {
    Color color;
    if (isError) {
      color = Theme.of(this).colorScheme.error;
    } else {
      color = Theme.of(this).colorScheme.primary;
    }
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(
          message,
        )));
  }
}
