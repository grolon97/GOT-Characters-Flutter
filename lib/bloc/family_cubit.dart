import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:bloc/bloc.dart';

import '../bloc/family_state.dart';
import '../repositories/family_repository.dart';
import '../models/family.dart';


class FamilyCubit extends Cubit<FamilyState> {
  final FamilyRepository _repository;
  final DatabaseReference _firebaseDatabase =
      FirebaseDatabase.instance.ref().child('favFamilies');
  List<Family> list = [];

  FamilyCubit(this._repository) : super(FamiliesInitial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      emit(FamiliesLoading());
      // will check for the favourites characters
      registerUpdatedFavsListener();
      list = await _repository.getFamiliesList();
      List<Family> favFamilies = await _repository.getFavouriteFamilies();

      emit(FamiliesLoaded(
          allFamilies: list, favFamilies: favFamilies)); // can be sent empty
    } catch (e, stack) {
      // print('error:  ${e.toString()} StackTrace: ${stack.toString()} ');
      emit(FamiliesError());
    }
  }

  // Temporal Hack, should be on an independent layer:
  // this method will register the listener that will change the cubit state when triggered
  void registerUpdatedFavsListener() {
    _firebaseDatabase.onValue.listen((event) {
      final eventData = event.snapshot.value;

      if (eventData != null) {
        List<Family> favFamilies = [];
        final firebaseData = Map<String, dynamic>.from(eventData as dynamic);

        firebaseData.forEach((key, value) {
          var jsonData = json.decode(json.encode(value));
          favFamilies.add(Family.fromJson(jsonData));
        });

        emit(FamiliesLoaded(allFamilies: list, favFamilies: favFamilies));
      } else {
        emit(FamiliesLoaded(allFamilies: list, favFamilies: const []));
      }
    }, onError: (error, stackTrace) {});
  }

  // method that uses current state array to check if it's favourite
  bool checkFavourite(Family family) {
    for (Family f in state.favFamilies) {
      if (f.id == family.id) {
        return true;
      }
    }
    return false;
  }

  Future<void> addFav(Family family) async {
    _repository.addFavouriteFamily(family);
  }

  Future<void> removeFav(Family family) async {
    _repository.removeFavouriteFamily(family);
  }
}
