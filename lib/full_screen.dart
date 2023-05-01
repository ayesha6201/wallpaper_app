import 'package:flutter/material.dart';

//simple wallpapers api integration.
class wallFullPage extends StatelessWidget {
  var imgUrl;

  wallFullPage(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 60.0),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.white,
                )),
          ),Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyIcon(icon: Icons.download, text: 'Download',),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyIcon(icon: Icons.brush_outlined, text: 'set'),
                  ),


                ],
              ),
            ],
          )


        ],

      ),
    );
  }
}
  class MyIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const MyIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  Container(
  height: 50,
  width: 50,
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(
  color: Colors.white.withOpacity(0.6),
  borderRadius: BorderRadius.circular(8),
  ),
  child: Icon(
  icon,
  color: Colors.white,
  ),
  ),
  Text(
  text,
  style: const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  );
  }
  }

