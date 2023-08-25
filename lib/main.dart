import 'package:flutter/material.dart';
import 'package:gastracker/widgets/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 16, 158, 177));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 16, 158, 177));

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: kDarkColorScheme.secondaryContainer,
            foregroundColor: kDarkColorScheme.onSecondaryContainer,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
              color: kDarkColorScheme.secondaryContainer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: GoogleFonts.roboto(
                  fontSize: 22,
                  color: kDarkColorScheme.onSecondaryContainer,
                ),
                titleMedium: GoogleFonts.roboto(
                  fontSize: 18,
                  color: kDarkColorScheme.onSecondaryContainer,
                ),
                titleSmall: GoogleFonts.roboto(
                  fontSize: 14,
                  color: kDarkColorScheme.onSecondaryContainer,
                ),
              ),
          iconTheme: IconThemeData(color: kDarkColorScheme.onPrimaryContainer)),
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
            color: kColorScheme.secondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.roboto(
                fontSize: 24,
                color: kColorScheme.onSecondaryContainer,
              ),
              titleMedium: GoogleFonts.roboto(
                fontSize: 20,
                color: kColorScheme.onSecondaryContainer,
              ),
              titleSmall: GoogleFonts.roboto(
                fontSize: 16,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
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
