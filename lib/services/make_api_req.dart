import 'dart:convert';

import 'package:http/http.dart' as http;

class AQIApiRequest {
  Future<Map<String, dynamic>> getData(
      String city, String state, String country) async {
    var httpReq = await http.get(Uri.parse(
        "http://api.airvisual.com/v2/city?city=$city&state=$state&country=$country&key=45c08cdf-8009-4835-b555-f55088d8af13"));

    // if (httpReq.statusCode == 200) {
    var jso = httpReq.body;
    print(jso);
    var js = jsonDecode(jso);

    Map<String, dynamic> result = {
      "aqiUs": js["data"]["current"]["pollution"]["aqius"],
      "mainPollutant": js["data"]["current"]["pollution"]["mainus"],
      "temperature": js["data"]["current"]["weather"]["tp"],
      "nameCity": js["data"]["city"],
    };
    print(result);
    // var r = AirQualityModel.fromJson(jsonDecode(httpReq.body));
    // print(r);
    return result;
  }
}
