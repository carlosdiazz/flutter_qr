import 'package:flutter/material.dart';
import 'package:qr/shared/shared.dart';

void showSnackBar(BuildContext context, ErrorMessageCustom errorMessage) {
  ScaffoldMessenger.of(context).clearSnackBars();
  if (errorMessage.isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(errorMessage.messageError),
        backgroundColor: Colors.redAccent,
        action: SnackBarAction(
          label: "Ok!",
          onPressed: () {},
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(errorMessage.messageError),
      backgroundColor: Colors.greenAccent,
      action: SnackBarAction(
        label: "Ok!",
        onPressed: () {},
      ),
    ));
  }
}
