import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/data/models/weather_model.dart';

class WeatherHours extends StatelessWidget {
  final WeatherModel? weatherModel;
  const WeatherHours({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:weatherModel?.forecast?.forecastday?[0].hour?.length ,
          itemBuilder: (context, index){
            final hourData = weatherModel?.forecast?.forecastday?[0].hour?[index];
            return Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Temperature show
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(hourData?.tempC?.round().toString() ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                      const Text("o",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  // weather image show
                  Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Image.network(
                          "http:${hourData?.condition?.icon ?? ''}"

                      )
                  ),
                  // time show
                  Text(
                    DateFormat.j().format(DateTime.parse(hourData?.time.toString() ?? ''),
                    ),
                    style: const TextStyle(color: Colors.white,fontSize: 15),
                  )
                ],
              ),

            );
          }
      ),
    );
  }
}