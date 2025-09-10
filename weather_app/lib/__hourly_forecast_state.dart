import 'package:flutter/material.dart';


class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String label;
  
  const HourlyForecast({
    super.key,
    required this.time,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
     elevation: 10,
     clipBehavior: Clip.hardEdge,
     child: Padding(
       padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10,),
       child: Column(
         children: [
           Text(
            time, 
            style: TextStyle(
             fontSize:20, 
             fontWeight: FontWeight.bold,
           ),),
           Icon(icon, size: 30,),
           Text(
            label,
             style: TextStyle(
             fontSize: 16,
            ),
           )
         ],                
       ),
     ),
   );
 }
}
