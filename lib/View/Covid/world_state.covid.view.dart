import 'package:apisflutter/Models/WorldStatsModel.dart';
import 'package:apisflutter/View/Covid/countries_data.covid.view.dart';
import 'package:apisflutter/services/covid_stats_api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsView extends StatefulWidget {
  const WorldStatsView({Key? key}) : super(key: key);

  @override
  State<WorldStatsView> createState() => _WorldStatsViewState();
}

class _WorldStatsViewState extends State<WorldStatsView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  final StatsApiServices statsApiServices = StatsApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              FutureBuilder(
                future: statsApiServices.worldStatsRecord(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.green,
                        size: 50.0,
                        controller: _animationController,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width / 1.2,
                          chartType: ChartType.disc,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                CustomRowWidget(
                                    title: "Today's Cases",
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                CustomRowWidget(
                                    title: "Death's",
                                    value: snapshot.data!.deaths.toString()),
                                CustomRowWidget(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                CustomRowWidget(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                CustomRowWidget(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CountriesStatsList(),
                              ),
                            );
                          },
                          child: Container(
                            height: 47,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  const CustomRowWidget({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
