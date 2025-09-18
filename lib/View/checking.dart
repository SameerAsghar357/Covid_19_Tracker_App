import 'package:flutter/material.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checking Image'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: const Center(
                child: Image(image: AssetImage('images/virus.png'))),
          ),
        ],
      ),
    );
  }
}
