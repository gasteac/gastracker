import 'package:flutter/material.dart';
import 'package:gastracker/widgets/expenses.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 16, 158, 177));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 16, 158, 177));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) =>
  runApp(
    MaterialApp(
      darkTheme: ThemeData(
        fontFamily: 'RobotoCondensed',
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme(
            color: kDarkColorScheme.secondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.secondaryContainer,
          foregroundColor: kDarkColorScheme.onSecondaryContainer,
        )),
        iconTheme: IconThemeData(color: kDarkColorScheme.onPrimaryContainer),
        floatingActionButtonTheme: const FloatingActionButtonThemeData()
            .copyWith(
                backgroundColor: kDarkColorScheme.secondaryContainer,
                foregroundColor: kDarkColorScheme.onSecondaryContainer),
      ),
      theme: ThemeData(
        fontFamily: 'RobotoCondensed',
        colorScheme: kColorScheme,
        cardTheme: CardTheme(
            color: kColorScheme.secondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.onSecondaryContainer,
        )),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData().copyWith(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.onSecondaryContainer,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
