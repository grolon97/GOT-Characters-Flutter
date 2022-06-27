import 'package:flutter/material.dart';
import 'package:got_app/models/character.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListViewItem extends StatelessWidget {
  final Character character;

  const CharacterListViewItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCubit characterCubit = context.read<CharacterCubit>();
    return Container(
      padding: const EdgeInsets.fromLTRB(7.5, 15, 7.5, 15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                    width: 120.0,
                    height: 105.0,
                    child: Image.network(character.imageUrl, fit: BoxFit.cover)),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Text(character.fullName),
                  Text(character.family)
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Center(
                    child: IconButton(
                  icon: characterCubit.checkFavourite(character)
                      ? const Icon(Icons.favorite_sharp,
                          color: Colors.redAccent)
                      : const Icon(Icons.favorite_border_outlined),
                  tooltip: 'Add to Favourites',
                  onPressed: () {
                    String snackBarText =
                        characterCubit.checkFavourite(character)
                            ? 'Favourite removed!'
                            : 'Favourite added!';
                    var snackBar = SnackBar(
                      content: Text(snackBarText),
                      duration: const Duration(milliseconds: 600),
                    );
                    characterCubit.changeFav(character);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ))),
          ]),
    );
  }
}
