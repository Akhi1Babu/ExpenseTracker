import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense.dart';
import 'package:flutter/services.dart';
var KColorScheme=ColorScheme.fromSeed(seedColor: const Color.fromARGB(
    255, 96, 59, 181),);
var darkColorScheme=ColorScheme.fromSeed(
  brightness:Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),);
  
void main(){



    runApp(MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkColorScheme,
        cardTheme: CardTheme(
          color: darkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: darkColorScheme.primaryContainer,
            )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.primaryContainer,

        ),
      ),
      theme:ThemeData().copyWith(colorScheme: KColorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: KColorScheme.primary,
            foregroundColor: KColorScheme.primaryContainer,

          ),
          cardTheme: CardTheme(
            color: KColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: KColorScheme.primaryContainer,
              )
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: KColorScheme.onSecondaryContainer,
                fontSize: 14,
              )
          )
      ),
      themeMode: ThemeMode.system,
      home: Expense( ),



    ),);


  }

  

  
  
