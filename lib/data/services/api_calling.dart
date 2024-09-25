import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_application/data/models/weather_model.dart';

class ApiCalling{

  Future<WeatherModel> getWeatherData( String searchText) async{

    try{
      // step-1: set the url
      String url = 'http://api.weatherapi.com/v1/forecast.json?key=aead3df92efc403b850155712242205&q=$searchText&days=7';

      // step-2 = Parse Url into uri
      Uri uri = Uri.parse(url);

      // step-3 = send request (GET)
      final Response response = await get(uri);

      // step-4 : check status-code
      if(response.statusCode == 200){
        // decode the data
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;

      }else{
        throw ("No user data found!");
      }

    } catch(e){
      throw e.toString();
    }

  }

}