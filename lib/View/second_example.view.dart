import 'dart:convert';
import 'package:apisflutter/Models/PhotosModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondExample extends StatefulWidget {
  const SecondExample({Key? key}) : super(key: key);

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosList() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photosModel = PhotosModel(title: i["title"], url: i["url"]);
        photosList.add(photosModel);
      }
      return photosList;
    } else {
      if (kDebugMode) {
        print("Something went Wrong");
      }
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Example API"),
        elevation: 1.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosList(),
              builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, bottom: 8.0),
                      child: ListTile(
                        title: Text(data.title.toString().toUpperCase()),
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(data.url),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
