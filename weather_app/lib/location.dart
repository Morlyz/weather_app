import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({
    super.key,
    required this.textEditingController,
    required this.icon,
  });

  final TextEditingController textEditingController;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: TextField(
          enabled: true,
          textAlignVertical: TextAlignVertical.bottom,
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            constraints: BoxConstraints(
              maxHeight: 40,
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)), 
              borderSide: BorderSide(
              width: 0,),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)), 
              borderSide: BorderSide(
              width: 0,),
            ),
            prefixIcon: icon,
            hintText: 'Enter location...',
            
          ),
        ),
    );
  }
}