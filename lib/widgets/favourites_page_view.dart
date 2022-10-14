import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_cubit.dart';
import '../bloc/character_state.dart';
import '../widgets/character_page.dart';
import '../widgets/add_character_page.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_message.dart';

class FavouritesPageView extends StatelessWidget {
  const FavouritesPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      // will check type of instance of a state. Depending on the result, it will render different components
      if (state is CharactersLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            LoadingMessage(message: 'Fetching Favourites...'),
          ],
        );
      }

      if (state is CharactersError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            ErrorMessage(message: 'An error has ocurred'),
          ],
        );
      }

      if (state is CharactersLoaded) {
        final PageController controller = PageController();

        // to check if there are favourites selected of all characters
        if (state.favCharacters.isNotEmpty) {
          return PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: state.favCharacters.length + 1,
            itemBuilder: (context, index) {
              return index <= (state.favCharacters.length - 1)
                  ? CharacterPage(character: state.favCharacters[index])
                  : const AddCharacterPage();
            },
          );
        } else {
          return PageView(controller: controller, children: const [
            AddCharacterPage(),
          ]);
        }
      }
      return const Text(
          'Favourite Characters Page'); // should be a widget with a placeholder
    });
  }
}
