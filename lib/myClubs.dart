import 'package:flutter/material.dart';
import 'package:bloon_pro/widget/myDrawer.dart';

class MyClubs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyClubsState();
  }
}


class _MyClubsState extends State<MyClubs>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(currentPage: 'myclubs'),
      appBar: AppBar(
        title: Text("Mes Clubs"),
      ),
      body: Center(
        child: Text("hello my clubs"),
      ),
    );
  }
}