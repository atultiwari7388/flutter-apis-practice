import 'dart:convert';
import 'package:apisflutter/Models/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThirdExample extends StatefulWidget {
  const ThirdExample({Key? key}) : super(key: key);

  @override
  State<ThirdExample> createState() => _ThirdExampleState();
}

class _ThirdExampleState extends State<ThirdExample> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUsersData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      if (kDebugMode) {
        print("Something went wrong !");
      }
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch User's Data"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersData(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomRowWidget(
                                  title: "Name: ", value: data.name.toString()),
                              CustomRowWidget(
                                  title: "UserName: ",
                                  value: data.username.toString()),
                              CustomRowWidget(
                                  title: "Email: ",
                                  value: data.email.toString()),
                              CustomRowWidget(
                                  title: "Address: ",
                                  value: data.address!.city.toString()),
                              CustomRowWidget(
                                  title: "ZipCode: ",
                                  value: data.address!.zipcode.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
