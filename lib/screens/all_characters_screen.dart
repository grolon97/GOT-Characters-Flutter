import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_cubit.dart';
import '../widgets/characters_list_widget.dart';
import '../themes/colors.dart' as colors;

class AllCharactersScreen extends StatelessWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCubit characterCubit = context.read<CharacterCubit>();
    characterCubit.filterCharactersByName('');
    var _textFieldController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: colors.primaryColor,
            title: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: SizedBox(
                width: double.infinity,
                // height: 40,
                child: Center(
                  child: TextField(
                      controller: _textFieldController,
                      onChanged: (text) {
                        characterCubit.filterCharactersByName(text);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: colors.lightColor,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            characterCubit.filterCharactersByName('');
                            _textFieldController.clear();
                          },
                        ),
                        hintText: 'Search...',
                      )),
                ),
              ),
            )),
        body: const CharactersList());
  }
}
