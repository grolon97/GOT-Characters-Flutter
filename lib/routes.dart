import 'package:flutter/widgets.dart';
import 'package:got_app/screens/home_screen.dart';
import 'package:got_app/screens/favourite_details_screen.dart';
import 'package:got_app/screens/all_characters_screen.dart';

var routes = <String, WidgetBuilder> {
  'HOME': (BuildContext) => const HomeScreen(),
  'FAVOURITE_DETAILS': (BuildContext) => const CharacterDetailsScreen(),
  'ALL_CHARACTERS': (BuildContext) => const AllCharactersScreen(),
};