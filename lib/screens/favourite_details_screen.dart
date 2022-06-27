import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:got_app/models/character.dart';
import 'package:got_app/bloc/character_state.dart';
import 'package:got_app/themes/app_theme.dart' as theme;


class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCubit characterCubit = context.read<CharacterCubit>();
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox.expand(
              // wrapper widget so the child can use it's whole width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'dash',
                    child: Material(
                      // just a hack, should investigate why this wrap is necessary
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            child: Image.network(character.imageUrl,
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                fit: BoxFit.fitWidth),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back,
                                  size: 32.0, color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Text(character.fullName, style: theme.headingTextStyle),
                  Text(character.family, style: theme.headingTextStyle),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton.icon(
                        icon: characterCubit.checkFavourite(character)
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border_outlined),
                        label: const Text('Remove Favourite'),
                        onPressed: characterCubit.checkFavourite(character)
                            ? () {
                                var snackBar = const SnackBar(
                                  content: Text('Favourite Removed!'),
                                  duration: Duration(milliseconds: 600),
                                );
                                characterCubit.changeFav(character);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            : null,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
