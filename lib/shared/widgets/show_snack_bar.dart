import 'package:flutter/material.dart';
import 'package:qr/shared/shared.dart';

void showSnackBar(BuildContext context, ErrorMessageCustom errorMessage) {
  ScaffoldMessenger.of(context).clearSnackBars();
  if (errorMessage.isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(errorMessage.messageError),
        backgroundColor: Colors.redAccent,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(errorMessage.messageError),
      backgroundColor: Colors.greenAccent,
    ));
  }
}
