import 'package:apisflutter/View/Covid/details_view.covid.view.dart';
import 'package:apisflutter/services/covid_stats_api.services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesStatsList extends StatefulWidget {
  const CountriesStatsList({Key? key}) : super(key: key);

  @override
  State<CountriesStatsList> createState() => _CountriesStatsListState();
}

class _CountriesStatsListState extends State<CountriesStatsList> {
  final TextEditingController _searchController = TextEditingController();

  final StatsApiServices statsApiService = StatsApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            //search
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (newValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search with Country Name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            //countries data
            Expanded(
              child: FutureBuilder(
                future: statsApiService.countriesStatsRecord(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.green.shade300,
                          highlightColor: Colors.green.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                    height: 10, width: 80, color: Colors.grey),
                                subtitle: Container(
                                    height: 10, width: 80, color: Colors.grey),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]["country"];
                      if (_searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsView(
                                      name: name,
                                      image: snapshot.data![index]
                                          ["countryInfo"]["flag"],
                                      critical: snapshot.data![index]
                                          ["critical"],
                                      active: snapshot.data![index]["active"],
                                      test: snapshot.data![index]["tests"],
                                      todayRecovered: snapshot.data![index]
                                          ["todayRecovered"],
                                      totalCases: snapshot.data![index]
                                          ["cases"],
                                      totalDeaths: snapshot.data![index]
                                          ["deaths"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsView(
                                      name: name,
                                      image: snapshot.data![index]
                                          ["countryInfo"]["flag"],
                                      critical: snapshot.data![index]
                                          ["critical"],
                                      active: snapshot.data![index]["active"],
                                      test: snapshot.data![index]["tests"],
                                      todayRecovered: snapshot.data![index]
                                          ["todayRecovered"],
                                      totalCases: snapshot.data![index]
                                          ["todayCases"],
                                      totalDeaths: snapshot.data![index]
                                          ["deaths"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
