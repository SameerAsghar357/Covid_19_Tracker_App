// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:covid_tracker/Model/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final colorList = const <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus(); // ✅ close keyboard when going back
        // return true; // allow popping
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              FutureBuilder(
                  future: statsServices.fetchworldstatsRecords(),
                  builder:
                      (context, AsyncSnapshot<world_stats_model> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: 'active',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: 'todayDeaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReusableRow(
                                      title: 'todayRecovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     );
                          //   },
                          //   child: Container(
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xff1aa260),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Center(
                          //       child: Text('Track Countries'),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: MaterialButton(
                              // padding: EdgeInsets.symmetric(horizontal: 50),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountriesListScreen()));
                              },
                              height: 50,
                              color: Color(0xff1aa260),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                // side: BorderSide(
                                //   color: Colors.black,
                                // ),
                              ),
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                              // child: Container(
                              //     padding: EdgeInsets.symmetric(vertical: 15),
                              //     decoration: BoxDecoration(
                              //         color: Color(0xff1aa260),
                              //         border: Border.all(color: Colors.white),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     child: Center(child: Text('Track Countries'))),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        )),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(
            thickness: 0.0,
          ),
        ],
      ),
    );
  }
}
