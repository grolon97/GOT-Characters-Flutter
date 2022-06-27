import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:got_app/bloc/character_state.dart';
import 'package:got_app/widgets/character_list_view_item.dart';
import 'package:got_app/widgets/error_message.dart';
import 'package:got_app/widgets/loading_message.dart';
import 'package:got_app/themes/colors.dart' as colors;

class AllCharactersScreen extends StatelessWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCubit characterCubit = context.read<CharacterCubit>();
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
                        characterCubit.getCharactersFilteredByName(text);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: colors.lightColor,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            characterCubit.getCharactersFilteredByName('');
                            _textFieldController.clear();
                          },
                        ),
                        hintText: 'Search...',
                        // border: InputBorder.none,
                      )),
                ),
              ),
            )),
        body: BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
          if (state is CharactersLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                LoadingMessage(message: 'Fetching All Characters...'),
              ],
            );
          }

          if (state is CharactersError) {
            return const ErrorMessage(message: 'An error has ocurred');
          }

          if (state is CharactersLoaded) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return CharacterListViewItem(
                    character: state.allCharacters[index]);
              },
              itemCount: state.allCharacters.length,
            );
          }

          // maybe this should go at the beginning
          return const ErrorMessage(
              message: 'An error has ocurred while loading the application.');
        }));
  }
}
