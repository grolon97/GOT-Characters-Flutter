import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:got_app/bloc/family_cubit.dart';
import 'package:got_app/bloc/family_state.dart';
import 'package:got_app/themes/colors.dart' as colors;
import 'package:got_app/widgets/characters_list_widget.dart';
import 'package:got_app/widgets/loading_message.dart';
import 'package:got_app/widgets/error_message.dart';
import 'package:got_app/models/family.dart';

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
          // here will go the name of the house
          title: Text(family.name),
          actions: <Widget>[
            IconButton(
                icon: familyCubit.checkFavourite(family)
                      ? const Icon(Icons.favorite_sharp,
                          color: Colors.redAccent)
                      : const Icon(Icons.favorite_border_outlined),
                tooltip: 'Add to Favorites',
                // will add the family name to favorites
                onPressed: () {
                  String snackBarText =
                        familyCubit.checkFavourite(family)
                            ? 'Family removed!'
                            : 'Family added!';
                    var snackBar = SnackBar(
                      content: Text(snackBarText),
                      duration: const Duration(milliseconds: 600),
                    );
                  familyCubit.changeFav(family);
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
