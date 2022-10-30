import 'package:firebase_database/firebase_database.dart';

import '../models/family.dart';

class FirebaseService {
  final FirebaseDatabase _databaseInstance = FirebaseDatabase.instance;
  final String _favsPath = 'favFamilies';

  Future<void> addFavFamily(Family family) async {
    _databaseInstance
        .ref(_favsPath)
        .update({'fav${family.id.toString()}': family.toJson()});
  }

  Future<void> removeFavFamily(Family family) async {
    await _databaseInstance
        .ref()
        .child('$_favsPath/fav${family.id.toString()}')
        .remove();
  }

  Future<dynamic> getFavouriteFamilies() async {
    final snapshot = await _databaseInstance.ref().child(_favsPath).get();
    if (snapshot.exists) {
      return snapshot.value;
    } else {
      return null;
    }
  }
}
