import 'package:flutter/material.dart';

class AddCharacterPage extends StatelessWidget {
  const AddCharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 3, color: Colors.grey)),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.add, color: Colors.grey, size: 36.0),
                  padding: const EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    Navigator.pushNamed(context, 'ALL_CHARACTERS');
                  }),
              const Text('Add Character', style: TextStyle(color: Colors.grey)),
            ],
          )),
    );
  }
}