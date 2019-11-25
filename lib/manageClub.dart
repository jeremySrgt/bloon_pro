import 'package:flutter/material.dart';


class ManageClub extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ManageClubState();
  }
}



class _ManageClubState extends State<ManageClub>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion du club YYY"),
      ),
      body: Center(
        child: Text('gestion de club'),
      ),
    );
  }
}