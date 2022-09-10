import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_state.dart';
import 'package:got_app/widgets/character_list_view_item.dart';
import 'package:got_app/widgets/error_message.dart';
import 'package:got_app/widgets/loading_message.dart';
import '../bloc/character_cubit.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
          if (state is CharactersLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                LoadingMessage(message: 'Fetching Characters...'),
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
        });
  }
}