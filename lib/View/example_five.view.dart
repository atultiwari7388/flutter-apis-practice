import 'package:apisflutter/Models/ProductsModel.dart';
import 'package:apisflutter/services/api.service.dart';
import 'package:flutter/material.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  // Future<ProductsModel> getProductData() async {
  //   final response = await http.get(
  //       Uri.parse("https://webhook.site/e7a3174a-bc31-4074-a15a-3b527f056384"));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     return ProductsModel.fromJson(data);
  //   } else {
  //     if (kDebugMode) {
  //       print("Something Went wrong");
  //     }
  //   }
  //   return ProductsModel.fromJson(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example Five"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: ApiServices().getProductData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                            // color: Colors.red,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index]
                                  .products![index].images!.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .5,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot
                                            .data!
                                            .data![index]
                                            .products![index]
                                            .images![position]
                                            .url
                                            .toString()
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot
                                        .data!
                                        .data![index]
                                        .products![index]
                                        .images![position]
                                        .filename
                                        .toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
