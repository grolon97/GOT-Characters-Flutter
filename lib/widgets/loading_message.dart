import 'package:flutter/material.dart';

class LoadingMessage extends StatelessWidget {
  final String message;

  const LoadingMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
      const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(message),
      )
    ]));
  }
}