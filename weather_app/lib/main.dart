import 'package:flutter/material.dart';
import 'package:weather_app/location.dart';

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

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Location(textEditingController: textEditingController),
              SizedBox(height: 50,),
              Center(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 40, bottom: 40,),
                    child: Column(
                      children: [
                        Text('300k', style: TextStyle(
                          fontSize: 25, 
                          fontWeight: FontWeight.bold,
                        ),),
                        Icon(Icons.cloud, size: 70,),
                        Text('Rain', style: TextStyle(
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
                    return HourlyForecast();
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
                  Column(
                    children: [
                      Icon(Icons.water_drop_outlined, size: 30,),
                      Text('Humidity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Text('0.4', style: TextStyle(fontSize: 16,),)
                    ],
                  ),
                   Column(
                    children: [
                      Icon(Icons.air_outlined, size: 30,),
                      Text('Humidity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Text('70Km/Hr', style: TextStyle(fontSize: 16,),)
                    ],
                  ),  Column(
                    children: [
                      Icon(Icons.stream_outlined, size: 30,),
                      Text('Pressure', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Text('1006', style: TextStyle(fontSize: 16,),)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HourlyForecast extends StatefulWidget {
  const HourlyForecast({
    super.key,
  });

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  @override
  Widget build(BuildContext context) {
    return Card(
     elevation: 10,
     clipBehavior: Clip.hardEdge,
     child: Padding(
       padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10,),
       child: Column(
         children: [
           Text('00:00', style: TextStyle(
             fontSize:20, 
             fontWeight: FontWeight.bold,
           ),),
           Icon(Icons.cloud, size: 30,),
           Text('307k', style: TextStyle(
             fontSize: 16,
           ),)
         ],                
       ),
     ),
                      );
  }
}
