import 'dart:developer';

import 'package:fancy_search_dropdown/fancy_search_dropdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fancy Search Dropdown"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FancySearchDropdown(
          labelText: "Selct Hospital Name",
          suggestions: const [
            "Family Doctor",
            "Preferred Doctor",
            "Preferred Hospital",
            "Care Taker",
            "Pharmacy",
            "Lab",
          ],
          selectedValue: "Lab",
          maxSuggestionHeight: 300,
          debugMode: false,
          // config: FancySearchDropdownConfig(
          //   optionBoxElevation: 3,
          //   inActiveSuffix: Icon(Icons.password),
          //   activeSuffix: Icon(Icons.email),
          //   borderRadius: 8,
          //   optionTextStyle: TextStyle(color: Colors.red),
          //   labelTextStyle: TextStyle(color: Colors.black),
          //   activeLeading: Icon(Icons.person),
          //   inputDecoration: InputDecoration(
          //     focusedBorder: OutlineInputBorder(),
          //     border: OutlineInputBorder(),
          //     enabledBorder: OutlineInputBorder(),
          //   ),
          // ),

          onSelected: (value) {
            log("Selected value: $value");
          },
        ),
      ),
    );
  }
}
