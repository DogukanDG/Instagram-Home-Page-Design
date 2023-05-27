import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addPage extends StatelessWidget {
  const addPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var userRef = firestore.collection("users");
    var random = new Random();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController commentcontroller = TextEditingController();
    TextEditingController imgUrlcontroller = TextEditingController();
    TextEditingController usercontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Post Add",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            TextFields(namecontroller, "Name", Icons.person),
            TextFields(commentcontroller, "Comment", Icons.comment),
            TextFields(imgUrlcontroller, "İmageURL", Icons.image),
            ElevatedButton(
                onPressed: () {
                  var likeNum = random.nextInt(400);
                  var commentNum = random.nextInt(100);
                  if (namecontroller.text == "Dogukan Dagtekin") {
                    usercontroller.text =
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600";
                  } else if (namecontroller.text == "Kagan Dagtekin") {
                    usercontroller.text =
                        "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
                  } else if (namecontroller.text == "Konce Dagtekin") {
                    usercontroller.text =
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
                  } else
                    usercontroller.text =
                        "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-symbol-image-default-avatar-profile-icon-vector-social-media-user-symbol-209498286.jpg";

                  var list = {
                    "name": "${namecontroller.text}",
                    "likes": likeNum,
                    "comment": "${commentcontroller.text}",
                    "imgUrl": "${imgUrlcontroller.text}",
                    "userPic": "${usercontroller.text}",
                    "commentNum": commentNum,
                  };
                  firestore.collection("users").doc().set(list);
                },
                child: Text("Add"))
          ],
        ));
  }
}

Widget TextFields(
    TextEditingController controller, String labelText, IconData iconData) {
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Form(
          child: Card(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: labelText,
              icon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(iconData),
              )),
        ),
      )),
    ),
  );
}
