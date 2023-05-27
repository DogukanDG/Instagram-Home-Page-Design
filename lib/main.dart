import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagrampost/views/addPage.dart';
import 'package:instagrampost/views/posts.dart';
import 'package:readmore/readmore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  List<Map> story = [
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "dogukan10"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "dogukannnn"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "useruser"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "user10"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "user23"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "user40"
    },
    {
      "userPic":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
      "name": "user89"
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.zero,
        child: BottomNav(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Instagram",
          style: TextStyle(
              fontSize: 28, fontFamily: 'Billabong', color: Colors.black),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 16), child: appBar(context))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: story.length,
                    itemBuilder: (context, index) {
                      return circleAvatars(
                          story[index]["userPic"], story[index]["name"]);
                    }),
              ),
            ),
            Posts(),
          ],
        ),
      )),
    );
  }
}

Widget appBar(context) {
  return Container(
    width: MediaQuery.of(context).size.width / 2.8,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return addPage();
              }));
            },
            icon: Icon(Icons.add_box_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.send),
        )
      ],
    ),
  );
}

Widget BottomNav() {
  return BottomNavigationBar(
      iconSize: 23,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: Colors.black),
          label: "Ana Sayfa",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black), label: "Keşfet"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.video_collection_outlined,
              color: Colors.black,
            ),
            label: "Reels"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            label: "Profile"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black), label: ""),
      ]);
}

Widget circleAvatars(String url, String name) {
  return Row(
    children: [
      Column(children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red), shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: NetworkImage("$url"),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "${name}",
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
        )
      ]),
      SizedBox(
        width: 15,
      )
    ],
  );
}
