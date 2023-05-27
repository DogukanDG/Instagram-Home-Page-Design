import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Posts extends StatelessWidget {
  Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var userRef = firestore.collection("users");
    return StreamBuilder<QuerySnapshot>(
        stream: userRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            List<DocumentSnapshot> list = asyncSnapshot.data.docs;
            if (list.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0, right: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(list[index]["userPic"]),
                                  maxRadius: 16),
                              title: Text(
                                list[index]["name"],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              horizontalTitleGap: 1,
                              //Burdaki iconu en sağa almanın bir yolunu bul
                              trailing: Icon(Icons.more_horiz_outlined),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            color: Colors.red,
                            width: double.infinity,
                            child: Image.network(
                              list[index]["imgUrl"],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.favorite_border),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(Icons.chat),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(Icons.send)
                                  ],
                                ),
                                Icon(Icons.bookmark_border)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${list[index]["likes"]} beğenme",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3),
                                  child: Container(
                                    width: 300,
                                    child: ReadMoreText(
                                      trimLines: 1,
                                      trimMode: TrimMode.Line,
                                      trimExpandedText: '',
                                      trimCollapsedText: 'more',
                                      list[index]["comment"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                        "${list[index]["commentNum"]} yorumun tümünü gör"))
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              );
            } else {
              return Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        "Lütfen borç yada alacak ekleyiniz",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                      Icon(
                        Icons.warning_amber,
                        size: 45,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              );
            }
          } else if (asyncSnapshot.hasError) {
            return SafeArea(
              child: Center(
                child: Text("HATA"),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
