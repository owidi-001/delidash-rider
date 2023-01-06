import 'package:flutter/material.dart';
import 'package:rider/theme/app_theme.dart';

SnackBar showMessage(bool success, String message, {int timeout = 1}) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: AppTheme.whiteColor),
    ),
    duration:  Duration(seconds: timeout),
    backgroundColor: success ? AppTheme.primaryColor : AppTheme.redColor,
    padding: const EdgeInsets.all(16.0),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
  );
}
