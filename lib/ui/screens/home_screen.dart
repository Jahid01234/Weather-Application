import 'package:flutter/material.dart';
import 'package:weather_application/data/models/weather_model.dart';
import 'package:weather_application/data/services/api_calling.dart';
import 'package:weather_application/ui/widgets/todays_weather.dart';
import 'package:weather_application/ui/widgets/weather_days.dart';
import 'package:weather_application/ui/widgets/weather_hour.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTextField = TextEditingController();
  String searchText = 'auto:ip';

  final ApiCalling _apiCalling = ApiCalling();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(onPressed: () async{
            _searchTextField.clear();
            String text = await _showTextInputDialog(context);
            setState(() {
              searchText = text;
            });

          },
            icon:const Icon(Icons.search),
          ),
          IconButton(onPressed: (){
            searchText = "auto:ip";
            setState(() {});
          },
            icon:const Icon(Icons.location_on),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _apiCalling.getWeatherData(searchText),
            builder:(context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ) {
                return const Center(child: Text('No data found'));
              } else {
                WeatherModel? weatherModel = snapshot.data;
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Column(
                    children: [
                      TodaysWeather(weatherModel: weatherModel),

                      const SizedBox(height: 10),
                      const Text(
                        "Weather By Hours",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),
                      WeatherHours(weatherModel: weatherModel),

                      const SizedBox(height: 10),
                      const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),
                      WeatherDays(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }
              },
            ),
        ),
      ),
    );
  }

  // search Dialog box
  _showTextInputDialog(BuildContext context) async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.grey,
        title:const Center(child: Text(
          "Search Location",
          style: TextStyle(color:Colors.white),
        ),
        ),
        content: TextField(
          controller: _searchTextField,
          style: const TextStyle(color:Colors.white),
          decoration: const InputDecoration(
            hintText: "City,Zip,Latitude and Longitude",
            hintStyle: TextStyle(color:Colors.white,fontSize: 14.0),
          ),
        ),

        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child:const Text("Cancel")
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey ,
              foregroundColor: Colors.white,
            ),
            onPressed: (){
              if(_searchTextField.text.isEmpty){
                return;
              }
              Navigator.pop(context,_searchTextField.text);
            },
            child:const Text("Ok"),
          ),
        ],
      );
    },
    );
  }
}