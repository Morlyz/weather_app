import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/__hourly_forecast_state.dart';
import 'package:weather_app/additional_item.dart';
import 'package:weather_app/location.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override build(BuildContext context){
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  double currentTemp = 0;
  String currentCloud = '';

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async{

    try {
      final String location = textEditingController.text == ''? 'london' : textEditingController.text;
    

    final res = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$location&APPID=ffc76fc5e820807892b871398e239fdb'),
    );

    final data = jsonDecode(res.body);
    if(data['cod'] != '200'){
      throw 'An error occured!';
    }

    return data; 
      
    } catch (e) {
      throw e.toString();
    }
     
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                 
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.refresh_outlined),
              ),
              )
          ],
        ),
        body: FutureBuilder(
          future: getCurrentWeather(), 
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting)
            {return const Center(child: CircularProgressIndicator());}

            if(snapshot.hasError){
              return Center(
                child : Text(snapshot.error.toString()),
              );
            }

             final data = snapshot.data!;
             final currentTemp = data['list'][0]['main']['temp'];
             final currentCloud = data['list'][0]['weather'][0]['main'];
             

            return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Location(
                textEditingController: textEditingController,
                icon: InkWell(
              onTap: (){
                setState(() {
                  getCurrentWeather();
                });
              },
              child: Icon(Icons.search_outlined)),
                ),
              SizedBox(height: 50,),
              Center(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 40, bottom: 40,),
                    child: Column(
                      children: [
                        Text('$currentTemp K', style: TextStyle(
                          fontSize: 25, 
                          fontWeight: FontWeight.bold,
                        ),),
                        Icon(currentCloud == 'Clouds' || currentCloud == 'Rain' ? Icons.cloud : Icons.wb_sunny_outlined, size: 70,),
                        Text(currentCloud, style: TextStyle(
                          fontSize: 20,
                        ),)
                      ],                
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35,),

              Text('Hourly Forecast', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22,
              ),),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    final sky = data['list'][index+1]['weather'][0]['main'].toString();
                    final clock = DateTime.parse(data['list'][index+1]['dt_txt']);
                    final temp = data['list'][index+1]['main']['temp'].toString();
                
                    return HourlyForecast(
                      time: DateFormat.Hm().format(clock),
                      icon: sky == 'Clouds' || sky == 'Rain'? Icons.cloud : Icons.wb_sunny_outlined,
                      label: '$temp k',
                    );
                  },
                ),
              ),
              SizedBox(height: 35,),

              Text('Additional Information', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22,
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdditionalItem(
                    icon: Icons.water_drop_outlined,
                    label: 'Humidity',
                    value: '${data['list'][0]['main']['humidity'].toString()} %',
                  ),
                   AdditionalItem(
                    icon: Icons.air_outlined,
                    label: 'Wind Speed',
                    value: '${data['list'][0]['wind']['speed'].toString()} km/hr',
                  ),
                   AdditionalItem(
                    icon: Icons.stream_outlined,
                    label: 'Pressure',
                    value: data['list'][0]['main']['pressure'].toString(),
                  ),
                ],
              )
            ],
          ),
        );
          }
          )
        
      ),
    );
  }
}
