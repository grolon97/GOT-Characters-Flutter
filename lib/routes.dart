import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'screens/character_details_screen.dart';
import '../screens/all_characters_screen.dart';
import '../screens/all_families_screen.dart';
import '../screens/family_characters_screen.dart';

/*
var routes = <String, WidgetBuilder> {
  'HOME': (BuildContext context) => const HomeScreen(),
  'FAVOURITE_DETAILS': (BuildContext context) => const CharacterDetailsScreen(),
  'ALL_CHARACTERS': (BuildContext context) => const AllCharactersScreen(),
  'ALL_FAMILIES': (BuildContext context) => const AllFamiliesScreen(),
  'FAMILY_CHARACTERS': (BuildContext context) => const FamilyCharactersScreen()
};
*/

class Routes {
  static const String home = '/';
  static const String characters = '/characters';
  static const String favCharacters = '/favCharacterDetails';
  static const String families = '/families';
  static const String familyDetails = '/familyDetails';
}

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);

    case Routes.characters:
      return MaterialPageRoute(
          builder: (context) => const AllCharactersScreen(),
          settings: settings);

    case Routes.favCharacters:
      return MaterialPageRoute(
          builder: (context) => const CharacterDetailsScreen(),
          settings: settings);

    case Routes.families:
      return MaterialPageRoute(
          builder: (context) => const AllFamiliesScreen(), settings: settings);

    case Routes.familyDetails:
      return MaterialPageRoute(
          builder: (context) => const FamilyCharactersScreen(),
          settings: settings);

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("404 Not Found")),
          settings: settings);
  }
}
