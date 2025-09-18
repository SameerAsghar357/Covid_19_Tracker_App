import 'package:covid_tracker/Services/Utilities/stats_services.dart';
import 'package:covid_tracker/View/details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    // FocusScope.of(context).unfocus(); // ✅ force keyboard close on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1.0,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    hintText: "Search Countries Here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                    future: statsServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      title: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (_searchController.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            ),
                                          ),
                                        ); // Navigator.push
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Image(
                                          height: 70,
                                          width: 70,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                      )
                                    ],
                                  ),
                                );
                              } else if (name.toLowerCase().contains(
                                  _searchController.text.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            ),
                                          ),
                                        ); // Navigator.push
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Image(
                                          height: 70,
                                          width: 70,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                Container();
                              }
                              return Container();
                            });
                      }
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
