import 'package:bloc_amplify/bloc/airQuality_bloc.dart';
import 'package:bloc_amplify/bloc/theme_bloc.dart';
import 'package:bloc_amplify/repository/airQuality_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),
        BlocProvider<AirQualityBloc>(
          create: (_) => AirQualityBloc(AirQualityRepository()),
        ),
      ],
      child: MyHomePage(),
    );
  }
}
