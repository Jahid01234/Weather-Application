import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/data/models/weather_model.dart';

class WeatherDays extends StatelessWidget {
  final WeatherModel? weatherModel;
  const WeatherDays({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:weatherModel?.forecast?.forecastday?.length,
          itemBuilder: (context, index){
            Forecastday? nextDayData = weatherModel?.forecast?.forecastday?[index];
            return Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // weather image show
                  Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Image.network(
                          "http:${nextDayData?.day?.condition?.icon ?? ''}"

                      )
                  ),
                  const SizedBox(width: 5.0),
                  // day and date show
                  Expanded(
                    child: Text(
                      DateFormat.MMMEd().format(DateTime.
                      parse(nextDayData?.date?.toString() ?? ''),
                      ),
                      style: const TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  ),
                  // weather name show
                  Expanded(
                    child: Text(nextDayData?.day?.condition?.text?.toString() ?? '',
                      style: const TextStyle(color: Colors.white,fontSize: 14),
                    ),
                  ),

                  // show maxTempC/ mimTempC
                  Wrap(
                    children: [
                      Text(
                        "^${nextDayData?.day?.maxtempC?.round().
                        toString() ?? ''}/${nextDayData?.day?.mintempC?.
                        round().toString() ?? ''}",
                        style: const TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ],
                  ),


                ],
              ),

            );
          }
      ),
    );
  }
}