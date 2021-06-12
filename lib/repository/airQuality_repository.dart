import 'package:bloc_amplify/models/airQuality_model.dart';
import 'package:bloc_amplify/services/make_api_req.dart';

abstract class AirQualityBaseRepository {
  Future<Map<String,dynamic>> getData(String city, String state, String country);
}

class AirQualityRepository implements AirQualityBaseRepository {
  @override
  Future<Map<String,dynamic>> getData(String city, String state, String country) async{
    print(city + state + country);
    var aQIApiRequest = AQIApiRequest();
    var r =await aQIApiRequest.getData(city, state, country);
    print("++++$r");
    return r;
    // return aQIApiRequest.getData(city, state, country);
  }
}
