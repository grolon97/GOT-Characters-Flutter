import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:got_app/bloc/family_cubit.dart';
import 'package:got_app/persistence/family_shared_preferences.dart';
import 'package:got_app/repositories/character_repository.dart';
import 'package:got_app/persistence/character_shared_preferences.dart';
import 'package:got_app/repositories/family_repository.dart';
import 'package:got_app/routes.dart';
import 'package:got_app/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Game of Thrones Characters';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (context) => CharacterCubit(
              CharacterRepository(), CharacterSharedPreferences()),
        ),
        BlocProvider<FamilyCubit>(
          create: (context) => FamilyCubit(FamilyRepository(), FamilySharedPreferences()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: AppTheme.lightTheme,
        routes: routes,
        initialRoute: 'HOME',
      ),
    );
  }
}
