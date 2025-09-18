// ignore_for_file: unused_import

import 'package:covid_tracker/Model/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:covid_tracker/View/checking.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  // printFunction();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
