import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeEvent { dark, light }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc()
      : super(ThemeData(
          backgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            color: Colors.grey[900],
          ),
        ));


  ThemeData darkTheme = ThemeData(
    backgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
    ),
  );

  
  ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.grey[300],
    ),
  );

  ThemeEvent currentTheme = ThemeEvent.dark;
  ThemeEvent get currentThemeEnum => currentTheme;

  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.dark:
        currentTheme = ThemeEvent.dark;
        yield darkTheme;
        break;
      case ThemeEvent.light:
        currentTheme = ThemeEvent.light;
        yield lightTheme;
        break;
      default:
        break;
    }
  }

  void toggleTheTheme() {
    print(currentTheme);
    add(currentTheme == ThemeEvent.dark ? ThemeEvent.light : ThemeEvent.dark);
  }
}
