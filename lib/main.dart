import 'package:flutter/material.dart';

// check if must delete imports
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_app/bloc/character_cubit.dart';
import 'package:got_app/bloc/family_cubit.dart';
import 'package:got_app/persistence/family_shared_preferences.dart';
import 'package:got_app/repositories/character_repository.dart';
import 'package:got_app/persistence/character_shared_preferences.dart';
import 'package:got_app/repositories/family_repository.dart';
import 'package:got_app/routes.dart';
import 'package:got_app/screens/home_screen.dart';
import 'package:got_app/themes/app_theme.dart';
import 'package:got_app/widgets/loading_message.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String _title = 'Game of Thrones Characters';

  final Future<FirebaseApp> _fbApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (context) => CharacterCubit(
              CharacterRepository(), CharacterSharedPreferences()),
        ),
        BlocProvider<FamilyCubit>(
          create: (context) => FamilyCubit(FamilyRepository()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          theme: AppTheme.lightTheme,
          onGenerateRoute: routes,
          home: SafeArea(
              child: Scaffold(
            body: FutureBuilder<FirebaseApp>(
                future: _fbApp,
                builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("An error has ocurred");
                  } else if (snapshot.hasData) {
                    // the future has been resolved and Firebase has been properly initialized
                    return const HomeScreen();
                  } else if (!snapshot.hasData) {
                    return const Text("Couldn't connect to the server. Please restart the application");
                  }
                  return const LoadingMessage(
                      message: "Connecting to Server...");
                }),
          ))),
    );
  }
}
