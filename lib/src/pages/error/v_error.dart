import 'package:flutter/material.dart';

class VError extends StatelessWidget {
  const VError({Key? key, required this.error}) : super(key: key);
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(error)),
    );
  }
}
