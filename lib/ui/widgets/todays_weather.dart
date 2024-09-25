import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/data/models/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({
    super.key,
    required this.weatherModel
  });

  @override
  Widget build(BuildContext context) {

    WeatherType _getWeatherType(Current? current) {
      if (current?.isDay == 1) {
        if (current?.condition?.text == "Sunny") {
          return WeatherType.sunny;
        } else if (current?.condition?.text == "Overcast") {
          return WeatherType.overcast;
        } else if (current?.condition?.text == "Partly cloudy") {
          return WeatherType.cloudy;
        } else if (current?.condition?.text == "Cloudy") {
          return WeatherType.cloudy;
        } else if (current?.condition?.text == "Clear") {
          return WeatherType.sunny;
        } else if (current?.condition?.text == "Mist") {
          return WeatherType.lightSnow;
        } else if (current!.condition!.text!.contains("thunder")) {
          return WeatherType.thunder;
        } else if (current!.condition!.text!.contains("showers")) {
          return WeatherType.middleSnow;
        } else if (current!.condition!.text!.contains("rain")) {
          return WeatherType.heavyRainy;
        }
      } else {
        if (current?.condition?.text == "Sunny") {
          return WeatherType.sunny;
        } else if (current?.condition?.text == "Overcast") {
          return WeatherType.overcast;
        } else if (current?.condition?.text == "Partly cloudy") {
          return WeatherType.cloudyNight;
        } else if (current?.condition?.text == "Cloudy") {
          return WeatherType.cloudyNight;
        } else if (current?.condition?.text == "Clear") {
          return WeatherType.sunnyNight;
        } else if (current?.condition?.text == "Mist") {
          return WeatherType.lightSnow;
        } else if (current!.condition!.text!.contains("thunder")) {
          return WeatherType.thunder;
        } else if (current!.condition!.text!.contains("showers")) {
          return WeatherType.middleSnow;
        } else if (current!.condition!.text!.contains("rain")) {
          return WeatherType.heavyRainy;
        }
      }
      return WeatherType.sunnyNight;
    }



    return Stack(
      children: [
        // 1st weatherBg
        WeatherBg(
            weatherType: _getWeatherType(weatherModel?.current),
            width: MediaQuery.sizeOf(context).width,
            height: 305
        ),

        // 2nd Text box
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 305,
          child: Column(
            children: [
              // 1st show location name and date time
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text(weatherModel?.location?.name ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.
                        parse(weatherModel?.current?.lastUpdated ?? ''),
                        ),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15, fontWeight: FontWeight.bold,
                        ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              // 2nd show weather image and weather Temperature
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 7.0),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle
                      ),
                      child: Image.network(
                          "http:${weatherModel?.current?.condition?.icon ?? ''}"
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  weatherModel?.current?.tempC?.round().toString() ?? '',
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                  ),
                                ),
                              ),
                              const Text("o",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                ),
                              ),

                            ],
                          ),

                          Wrap(
                            children: [
                              Text(weatherModel?.current?.condition?.text ?? '',
                                style: const TextStyle(
                                    fontSize: 15,color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ) ,
              ),
              // 3rd container
              const SizedBox(height: 30),
              Container(
                //margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  children: [
                    // 1st row show feels like and wind
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 1st column Feels Like
                        Column(
                          children: [
                            const Text("Feels Like",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "${weatherModel?.current?.feelslikeC?.
                                round().toString() ?? ''}°",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),

                        // 2nd column Feels Like
                        Column(
                          children: [
                            const Text("Wind",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "${weatherModel?.current?.windKph?.
                                round().toString() ?? ''} km/h",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),
                      ],


                    ),
                    // Divider part
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child:  Divider(color: Colors.grey),
                    ),
                    // 2nd row show humidity and visibility
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 1st column Feels Like
                        Column(
                          children: [
                            const Text("Humidity",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "${weatherModel?.current?.humidity.toString() ?? ''} %",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),

                        // 2nd column Feels Like
                        Column(
                          children: [
                            const Text("Visibility",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "${weatherModel?.current?.visKm?.round().toString() ?? ''} km",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),
                      ],


                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}