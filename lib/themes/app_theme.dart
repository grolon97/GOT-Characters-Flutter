import 'package:flutter/material.dart';
import '../themes/colors.dart' as colors;

// Padding, Margin and Positioning...
const DEFAULT_PADDING = 16.0;
const DEFAULT_MARGIN = 16.0;
const DEFAULT_BORDER_RADIUS = 5.0;

// Text Styles
// const DEFAULT

// pendiente de completarse para que modifique totalmente el look and feel de la aplicación
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: colors.primaryColor, primary: colors.primaryColor),
        brightness: Brightness.light,
        primaryColor: colors.primaryColor,
        indicatorColor: colors.primaryColor,
        scaffoldBackgroundColor: Colors.white, // this is not working
        appBarTheme: appBarTheme,
        tabBarTheme: tabBarTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        snackBarTheme: snackBarTheme);
  }
}

var appBarTheme = const AppBarTheme().copyWith(
  elevation: 0,
);

var tabBarTheme = const TabBarTheme().copyWith(
    labelColor: colors.textColor,
    unselectedLabelColor: colors.lightColor,
    // unselectedLabelStyle: const TextStyle(backgroundColor: white),
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: const BoxDecoration(
      color: colors.lightColor,
      boxShadow: [
        BoxShadow(
            offset: Offset.zero,
            color: Colors.black,
            blurRadius: 15,
            blurStyle: BlurStyle.outer)
      ],
      borderRadius: BorderRadius.all(Radius.circular(40)),
      /*gradient: LinearGradient(
        colors: [orangePink, orange],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ), */
    ));

var elevatedButtonThemeData = ElevatedButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: colors.primaryColor,
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))));

var snackBarTheme = SnackBarThemeData(
  backgroundColor: colors.primaryColor,
  contentTextStyle: const TextStyle(color: colors.lightColor),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.red, width: 1),
    borderRadius: BorderRadius.circular(24),
  ),
);

var headingTextStyle = const TextStyle(
  color: colors.textColor,
  fontSize: 17.5,
  fontWeight: FontWeight.bold,
  height: 2,
);
