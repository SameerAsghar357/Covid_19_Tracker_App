// ignore_for_file: must_be_immutable

import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  String name, image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      test,
      todayRecovered,
      critical;

  DetailsPage(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalRecovered,
      required this.totalDeaths,
      required this.active,
      required this.test,
      required this.todayRecovered,
      required this.critical});

  // DetailsPage({required this.name});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

// https://jsonplaceholder.typicode.com/posts

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  // margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .10),
                      ReusableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReusableRow(title: 'Test', value: widget.test.toString()),
                      ReusableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      ReusableRow(
                          title: 'Critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      )),
    );
  }
}
