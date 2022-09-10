import 'package:flutter/widgets.dart';
import 'package:got_app/screens/home_screen.dart';
import 'package:got_app/screens/favourite_details_screen.dart';
import 'package:got_app/screens/all_characters_screen.dart';
import 'package:got_app/screens/all_families_screen.dart';
import 'package:got_app/screens/family_characters_screen.dart';

var routes = <String, WidgetBuilder> {
  'HOME': (BuildContext context) => const HomeScreen(),
  'FAVOURITE_DETAILS': (BuildContext context) => const CharacterDetailsScreen(),
  'ALL_CHARACTERS': (BuildContext context) => const AllCharactersScreen(),
  'ALL_FAMILIES': (BuildContext context) => const AllFamiliesScreen(),
  'FAMILY_CHARACTERS': (BuildContext context) => const FamilyCharactersScreen()
};