

abstract class AirQualityState {
  const AirQualityState();
}

class AirQualityInitial extends AirQualityState {
  const AirQualityInitial();
}

class AirQualityLoading extends AirQualityState {
  const AirQualityLoading();
}

class AirQualityLoaded extends AirQualityState {
  final Map<String,dynamic> airQualityModel;
  const AirQualityLoaded(this.airQualityModel);
}

class AirQualityError extends AirQualityState {
  final String message;
  const AirQualityError(this.message);
}