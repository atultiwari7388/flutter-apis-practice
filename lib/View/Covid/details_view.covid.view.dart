import 'package:apisflutter/View/Covid/world_state.covid.view.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    Key? key,
    required this.name,
    required this.image,
    required this.critical,
    required this.active,
    required this.test,
    required this.todayRecovered,
    required this.totalCases,
    required this.totalDeaths,
  }) : super(key: key);
  final String name, image;
  final int totalCases, totalDeaths, active, critical, todayRecovered, test;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .067),
                      CustomRowWidget(
                          title: "Cases", value: widget.totalCases.toString()),
                      CustomRowWidget(
                          title: "TotalDeaths",
                          value: widget.totalDeaths.toString()),
                      CustomRowWidget(
                          title: "Active", value: widget.active.toString()),
                      CustomRowWidget(
                          title: "Critical", value: widget.critical.toString()),
                      CustomRowWidget(
                          title: "Today Recovered",
                          value: widget.todayRecovered.toString()),
                      CustomRowWidget(
                          title: "Tests", value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
