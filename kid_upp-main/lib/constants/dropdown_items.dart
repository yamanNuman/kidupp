import 'package:flutter/material.dart';

class DropDownItems {
  static List<DropdownMenuItem<String>> get dropdownDays {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(
          value: "Pazartesi",
          child: Text(
            "Pazartesi",
            style: TextStyle(fontSize: 20),
          )),
      DropdownMenuItem(
          value: "Salı", child: Text("Salı", style: TextStyle(fontSize: 20))),
      DropdownMenuItem(
          value: "Çarşamba",
          child: Text("Çarşamba", style: TextStyle(fontSize: 20))),
      DropdownMenuItem(
          value: "Perşembe",
          child: Text("Perşembe", style: TextStyle(fontSize: 20))),
      DropdownMenuItem(
          value: "Cuma", child: Text("Cuma", style: TextStyle(fontSize: 20))),
      DropdownMenuItem(
          value: "Cumartesi",
          child: Text("Cumartesi", style: TextStyle(fontSize: 20))),
      DropdownMenuItem(
          value: "Pazar", child: Text("Pazar", style: TextStyle(fontSize: 20))),
    ];
    return menuItems;
  }
}
