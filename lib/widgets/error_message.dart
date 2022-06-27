import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;


  const ErrorMessage({ Key? key, required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: $message'),
              )
            ]
      )
    );
  }
}