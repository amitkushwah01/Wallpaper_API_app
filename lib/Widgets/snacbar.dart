import 'package:flutter/material.dart';

class MySnackbar extends StatelessWidget {
  final String message;

  MySnackbar(this.message);

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );

    return Container();
  }
}
