import 'dart:convert';
import 'package:flutter/material.dart';

//dribble wallpaper UI api integration.
import 'package:http/http.dart' as http;
import 'photo_model.dart';
import 'full_screen.dart';


class SearchPage extends StatefulWidget {
  String query;

  SearchPage(this.query);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late Future<photoModel> arrPhotos;

  @override
  void initState() {
    arrPhotos = getWallpapers(widget.query, "color");

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
      ),
      body: FutureBuilder<photoModel>(
        future: arrPhotos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 11,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  var imgUrl = snapshot.data!.photos![index].src!.portrait!;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => wallFullPage(imgUrl),
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.photos!.length,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
            print("Error: ${snapshot.error}");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<photoModel> getWallpapers(String query, String color) async {
    print("query: $query");
    var myUrl =
        "https://api.pexels.com/v1/search?query=$query&color=$color&per_page=100";
    var data = await http.get(Uri.parse(myUrl), headers: {
      "Authorization":
      "563492ad6f91700001000001bfb4c79192b148adaaf4e2a97c9644d5"
    });
    photoModel model = photoModel();

    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      model = photoModel.fromJson(jsonData);

      setState(() {});

      print("jsonData: $jsonData");
    } else {
      print("response not fetched,due to ${data.statusCode}");
    }
    return model;
  }
}
