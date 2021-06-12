abstract class AirQualityEvent {
  const AirQualityEvent();
}

class GetAirQuality extends AirQualityEvent {
  final String cityName;
  final String state,country;
  const GetAirQuality(this.cityName,this.state,this.country);
}
