import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(
    const MaterialApp(
      home: search(),
    ),
  );
}

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  Weather? weather;
  final openweather=WeatherFactory('2377570b686ef85b1d22d0dcad938057');
  String cityName='';
  getweather()async{
    try{
      weather=await openweather.currentWeatherByCityName(cityName);
    setState(() {});
    }catch(e) {
      print('The Error $e');

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text('search by city name'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(22.0),
            child: TextField(
              onChanged: (value){
                setState(() {
                  cityName=value;
                });
              },
              decoration: InputDecoration(
                hintText: 'search by city',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    getweather();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: weather!=null? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather!.temperature!.celsius!.round()} ',
                style: TextStyle(
                  fontSize: 55.0,
                ),
                ),
                Text('${weather!.weatherDescription}'),
              ],
            ):const SizedBox(),
          )
        ],
      ),
    );
  }
}
