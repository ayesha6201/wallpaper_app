import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/search.dart';
import 'photo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: WallpaperNew(),
    );
  }
}

class WallpaperNew extends StatefulWidget {
  const WallpaperNew({super.key});

  @override
  State<StatefulWidget> createState() => WallpaperNewState();
}

class WallpaperNewState extends State<WallpaperNew> {
  late Future<photoModel> arrPhotos;

  var arrColors = [
    {
      "name": "red",
      "color": Colors.red,
    },
    {
      "name": "blue",
      "color": Colors.blue,
    },
    {
      "name": "black",
      "color": Colors.black,
    },
    {
      "name": "yellow",
      "color": Colors.yellow,
    },
    {
      "name": "pink",
      "color": Colors.pink,
    },
    {
      "name": "brown",
      "color": Colors.brown,
    },
    {
      "name": "green",
      "color": Colors.green,
    },
    {
      "name": "grey",
      "color": Colors.grey,
    },
    {
      "name": "white",
      "color": Colors.white,
    }
  ];

  @override
  void initState() {
    arrPhotos = getWallpapers("nature", "color",);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("WALLPAPER"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<photoModel>(
          future: arrPhotos,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Column(
                    children: [
                      Expanded(flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(searchController.text.toString()),));
                                    /* arrPhotos = getWallpapers(
                                        searchController.text.toString() != ""
                                            ? searchController.text.toString()
                                            : "nature",
                                        "color");*/
                                  },
                                  child: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Best Of The Month",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemExtent: 100,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.photos!.length,
                          itemBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 110,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(21.0),
                                    child: Image.network(snapshot.data!.photos![index].src!.portrait!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Text("The Color Tone", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: arrColors.length,
                                itemBuilder: (context, index) =>
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(arrColors[index]['name'].toString(),)));
                                        /*  arrPhotos = getWallpapers(
                                            searchController.text.toString() != ""
                                                ? searchController.text.toString()
                                                : "nature",
                                            arrColors[index]['name'].toString());*/
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // margin: EdgeInsets.all(10),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: arrColors[index]['color']! as Color,
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            Text("Categories", style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),),
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: (){
                                  arrPhotos = getWallpapers(
                                      searchController.text.toString() != ""
                                          ? searchController.text.toString()
                                          : "nature",
                                      "color");

                                },
                                child: InkWell(
                                  onTap: (){
                                    arrPhotos = getWallpapers(
                                        searchController.text.toString() != ""
                                            ? searchController.text.toString()
                                            : "nature",
                                        "color");
                                  },
                                  child: GridView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(12),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 16 / 9,
                                    ),
                                    children: [
                                      CategoryCard(
                                        image: "assets/images/abstrackimage.jpg",
                                        text: "Abstrack",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("abstract"),));
                                        },
                                      ),
                                      CategoryCard(
                                        image: "assets/images/nature.jpg",
                                        text: "Nature",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("Nature"),));
                                        },
                                      ),
                                      CategoryCard(
                                        image: "assets/images/flowernew.jpg",
                                        text: "Flowers",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("Flowers"),));
                                        },
                                      ),
                                      CategoryCard(
                                        image: "assets/images/animalnew.jpg",
                                        text: "Animals",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("Animals"),));
                                        },
                                      ),
                                      CategoryCard(
                                        image: "assets/images/sky.jpg",
                                        text: "Sky",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("Sky"),));
                                        },
                                      ),
                                      CategoryCard(
                                        image: "assets/images/oceans.jpg",
                                        text: "Oceans",
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage("Oceans"),));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError){
              return Text('Network Error!');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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

class CategoryCard extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.image,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.8,
              ),
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
