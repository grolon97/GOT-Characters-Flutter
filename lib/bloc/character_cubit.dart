import 'package:bloc/bloc.dart';
import 'package:got_app/bloc/character_state.dart';
import 'package:got_app/persistence/shared_preferences.dart';
import 'package:got_app/repositories/character_repository.dart';
import 'package:got_app/models/character.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository _repository;
  final CharacterSharedPreferences _preferences;
  List<Character> list = [];

  CharacterCubit(this._repository, this._preferences)
      : super(CharactersInitial()) {
        _init();
      }

  // will send states to the bloc provider or builder, this works as an init method
  Future<void> _init() async {
    try {
      emit(CharactersLoading());
      // will check for the favourites characters
      list = await _repository.getCharactersList();
      List<int> favsIDs = _preferences.getFavouritesList();
      // filter the favourites in another list
      List<Character> favsList = [];
      for (Character c in list) {
        if (favsIDs.contains(c.id)) {
          favsList.add(c);
        }
      }

      emit(CharactersLoaded(
          allCharacters: list, favCharacters: favsList)); // can be sent empty
    } catch (e) {
      emit(CharactersError());
    }
  }
/*
  Future<void> getFavouriteCharacters() async {
    List<Character> allCharacters = await _repository.getCharactersList();
    List<int> favsList = _preferences.getFavouritesList();
    List<Character> favCharacters = [];
    for (Character c in allCharacters) {
      if (favsList.contains(c.id)) {
        favCharacters.add(c);
      }
    }
    emit(CharactersLoaded(list: favCharacters));
  }
*/

  Future<void> changeFav(Character character) async {
    List<int> favsList = _preferences.getFavouritesList();
    List<Character> updatedFavs = state.favCharacters;
    if (favsList.contains(character.id)) {
      favsList.remove(character.id);
      updatedFavs.remove(character);
    } else {
      favsList.add(character.id);
      updatedFavs.add(character);
    }
    _preferences.setFavouritesList(favsList);
    emit(state.copyWith(
        allCharacters: state.allCharacters, favCharacters: updatedFavs));
  }

  bool checkFavourite(Character character) {
    return _preferences.getFavouritesList().contains(character.id);
  }

  Future<void> getCharactersFilteredByName(String keyword) async {
    if (keyword.isEmpty) {
      // to force a re-rendering
      emit(state.copyWith(allCharacters: list));
    } else {
      List<Character> filteredCharacters = list
          .where((character) =>
              character.fullName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();

      emit(state.copyWith(allCharacters: filteredCharacters));
    }
  }
}
