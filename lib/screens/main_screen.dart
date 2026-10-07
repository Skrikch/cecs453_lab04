// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Put properties and stuff here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Britney & Christos\' Mortgage Calculator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            // We need to figure out how to align all entries on this screen
            // Like an invisible table or something.
            Padding(padding: EdgeInsets.symmetric(vertical:10)),
            Text("Amount:\t ${amount}")
          ]
        )
      )
    );
  }
}