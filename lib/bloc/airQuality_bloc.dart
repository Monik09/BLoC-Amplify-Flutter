import 'package:bloc_amplify/bloc/airQuality_event.dart';
import 'package:bloc_amplify/bloc/airQuality_state.dart';
import 'package:bloc_amplify/models/airQuality_model.dart';
import 'package:bloc_amplify/repository/airQuality_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirQualityBloc extends Bloc<AirQualityEvent, AirQualityState> {
  final AirQualityBaseRepository _repository;

  AirQualityBloc(this._repository) : super(AirQualityInitial());

  @override
  Stream<AirQualityState> mapEventToState(AirQualityEvent event) async* {
    final request;
    yield AirQualityLoading();
    if (event is GetAirQuality) {
      print("hooo");
      try {
        print("hooo1");
        request = await _repository.getData(
            event.cityName, event.state, event.country);
        yield AirQualityLoaded(request);
      } catch (e) {
        yield AirQualityError("Check spelling or internet availability");
      }
    }
  }
}
