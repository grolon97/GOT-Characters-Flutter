import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_cubit.dart';
import '../bloc/family_cubit.dart';
import '../bloc/family_state.dart';
import '../themes/colors.dart' as colors;
import '../widgets/characters_list_widget.dart';
import '../models/family.dart';

class FamilyCharactersScreen extends StatelessWidget {
  const FamilyCharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Family family = ModalRoute.of(context)!.settings.arguments as Family;

    // we set the family cubit to use it's id
    FamilyCubit familyCubit = context.read<FamilyCubit>();
    CharacterCubit characterCubit = context.read<CharacterCubit>();
    characterCubit.filterCharactersByFamilyId(family.id);

    return BlocBuilder<FamilyCubit, FamilyState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.primaryColor,
          title: Text(family.name),
          actions: <Widget>[
            IconButton(
                icon: familyCubit.checkFavourite(family)
                    ? const Icon(Icons.favorite_sharp, color: Colors.white)
                    : const Icon(Icons.favorite_border_outlined),
                tooltip: 'Add to Favorites',
                onPressed: () {
                  String snackBarText = familyCubit.checkFavourite(family)
                      ? 'Family removed!'
                      : 'Family added!';
                  var snackBar = SnackBar(
                    content: Text(snackBarText),
                    duration: const Duration(milliseconds: 600),
                  );
                  familyCubit.checkFavourite(family)
                      ? familyCubit.removeFav(family)
                      : familyCubit.addFav(family);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                })
          ],
        ),
        body: const SafeArea(
          child: CharactersList(),
        ),
      );
    });
  }
}
