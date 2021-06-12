import 'package:bloc_amplify/bloc/airQuality_bloc.dart';
import 'package:bloc_amplify/bloc/airQuality_event.dart';
import 'package:bloc_amplify/bloc/airQuality_state.dart';
import 'package:bloc_amplify/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context2, state) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: state,
        home: Scaffold(
          backgroundColor: themeBloc.currentThemeEnum == ThemeEvent.dark
              ? Colors.black
              : Colors.white,
          appBar: AppBar(
            title: Text(
              "hi",
              style: TextStyle(
                  color: themeBloc.currentThemeEnum == ThemeEvent.dark
                      ? Colors.white
                      : Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  themeBloc.toggleTheTheme();
                },
                icon: Icon(
                  themeBloc.currentTheme == ThemeEvent.dark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: themeBloc.currentTheme == ThemeEvent.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          body: BlocListener<AirQualityBloc, AirQualityState>(
            listener: (context, state) {
              if (state is AirQualityError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: BlocBuilder<AirQualityBloc, AirQualityState>(
              builder: (blc, st) => SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _cityNameController,
                                style: TextStyle(
                                    color: themeBloc.currentThemeEnum ==
                                            ThemeEvent.dark
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Enter city name",
                                    hintStyle: TextStyle(
                                        color: themeBloc.currentThemeEnum ==
                                                ThemeEvent.dark
                                            ? Colors.white
                                            : Colors.black),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: themeBloc.currentThemeEnum ==
                                                    ThemeEvent.dark
                                                ? Colors.white
                                                : Colors.black))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _stateNameController,
                                style: TextStyle(
                                    color: themeBloc.currentThemeEnum ==
                                            ThemeEvent.dark
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Enter state name",
                                    hintStyle: TextStyle(
                                        color: themeBloc.currentThemeEnum ==
                                                ThemeEvent.dark
                                            ? Colors.white
                                            : Colors.black),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: themeBloc.currentThemeEnum ==
                                                    ThemeEvent.dark
                                                ? Colors.white
                                                : Colors.black))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _countryNameController,
                                style: TextStyle(
                                    color: themeBloc.currentThemeEnum ==
                                            ThemeEvent.dark
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Enter country name",
                                    hintStyle: TextStyle(
                                        color: themeBloc.currentThemeEnum ==
                                                ThemeEvent.dark
                                            ? Colors.white
                                            : Colors.black),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: themeBloc.currentThemeEnum ==
                                                    ThemeEvent.dark
                                                ? Colors.white
                                                : Colors.black))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    print(_cityNameController.value.text);
                                    print(_stateNameController.value.text);
                                    print(_countryNameController.value.text);
                                    final _bloc =
                                        BlocProvider.of<AirQualityBloc>(
                                            context);
                                    _bloc.add(
                                      GetAirQuality(
                                        _cityNameController.value.text
                                            .trim()
                                            .toLowerCase(),
                                        _stateNameController.value.text
                                            .trim()
                                            .toLowerCase(),
                                        _countryNameController.value.text
                                            .trim()
                                            .toLowerCase(),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (st is AirQualityLoading)
                        CircularProgressIndicator()
                      else if (st is AirQualityLoaded)
                        Container(
                          height: 80,
                          width: 200,
                          color: Colors.red,
                          child: showData(context, st.airQualityModel),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget showData(BuildContext ctx, Map<String, dynamic> airQualityModel) {
    print("show data");
    print(airQualityModel);
    return Center(
      child: Container(
        height: 80,
        child: Text(
            "AQI: ${airQualityModel['aqiUs']} \nMain Pollutant: ${airQualityModel['mainPollutant']} \nTemperature: ${airQualityModel['temperature']}"),
      ),
    );
  }
}
