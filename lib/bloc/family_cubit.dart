import 'package:bloc/bloc.dart';
import 'package:got_app/bloc/family_state.dart';
import 'package:got_app/persistence/family_shared_preferences.dart';
import 'package:got_app/repositories/family_repository.dart';
import '../repositories/character_repository.dart';
import 'package:got_app/models/family.dart';
import '../models/character.dart';

class FamilyCubit extends Cubit<FamilyState> {
  final FamilyRepository _repository;
  final FamilySharedPreferences _preferences;
  List<Family> list = [];

  FamilyCubit(this._repository, this._preferences) : super(FamiliesInitial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      emit(FamiliesLoading());
      // will check for the favourites characters
      list = await _repository.getHousesList();
      List<int> favsIds = _preferences.getFavouriteFamilies();

      List<Family> favsList = [];
      for (Family f in list) {
        if (favsIds.contains(f.id)) {
          favsList.add(f);
        }
      }

      emit(FamiliesLoaded(
          allFamilies: list, favFamilies: favsList)); // can be sent empty
    } catch (e, stack) {
      emit(FamiliesError());
    }
  }

  bool checkFavourite(Family family) {
    return _preferences.getFavouriteFamilies().contains(family.id);
  }

  Future<void> changeFav(Family family) async {
    List<int> favsList = _preferences.getFavouriteFamilies();
    List<Family> updatedFavs = state.favFamilies;
    if (favsList.contains(family.id)) {
      favsList.remove(family.id);
      updatedFavs.remove(family);
    } else {
      favsList.add(family.id);
      updatedFavs.add(family);
    }
    _preferences.setFavouriteFamilies(favsList);

    emit(state.copyWith(
        allFamilies: state.allFamilies, favFamilies: updatedFavs));
  }
}
