import 'package:flutter/material.dart';

class CountriesStatsList extends StatefulWidget {
  const CountriesStatsList({Key? key}) : super(key: key);

  @override
  State<CountriesStatsList> createState() => _CountriesStatsListState();
}

class _CountriesStatsListState extends State<CountriesStatsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries Stats List"),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
