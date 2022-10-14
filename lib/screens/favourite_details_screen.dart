import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_cubit.dart';
import '../models/character.dart';
import '../bloc/character_state.dart';
import '../themes/app_theme.dart' as theme;

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCubit characterCubit = context.read<CharacterCubit>();
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        IconData? favIconData = characterCubit.checkFavourite(character)
            ? Icons.favorite
            : Icons.favorite_border_outlined;

        return Scaffold(
          body: SafeArea(
              // wrapper widget so the child can use it's whole width
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'dash',
                    child: Material(
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            child: Image.network(character.imageUrl,
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 400,
                                fit: BoxFit.fitWidth),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 32.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(1, 2),
                                      blurRadius: 15)
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  Text(character.fullName, style: theme.headingTextStyle),
                  Text(character.familyName.toString()),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton.icon(
                          icon: Icon(favIconData),
                          label: characterCubit.checkFavourite(character)
                              ? const Text('Remove Favourite')
                              : const Text('Add Favourite'),
                          onPressed: () {
                            characterCubit.changeFav(character);
                            String snackText =
                                characterCubit.checkFavourite(character)
                                    ? 'Favourite Added!'
                                    : 'Favourite Removed!';
                            var snackBar = SnackBar(
                              content: Text(snackText),
                              duration: const Duration(milliseconds: 600),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 60)))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
