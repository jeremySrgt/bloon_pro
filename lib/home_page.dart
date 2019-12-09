import 'package:flutter/material.dart';
import 'package:bloon_pro/authentification/auth.dart';
import 'package:bloon_pro/widget/myDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'graphs/test.dart';
import 'graphs/bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pink, Colors.deepPurple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));


  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bloon Pro'),
        actions: <Widget>[
          new FlatButton(
            child: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white,),
            onPressed: signOut,
          )
        ],
      ),
      drawer: MyDrawer(currentPage: 'home', userId: null),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Comment se porte votre club ?", style: TextStyle(
                    fontSize: 20.0,
                    foreground: Paint()..shader = linearGradient),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,25.0),
                child: Text("Nombre d'entrés cette semaine"),
              ),
              BarChartSample3(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,25.0),
                child: Text("Vos revenues estimés"),
              ),

              LineChartSample2(),
            ],
          ),
        ),
      )
    );
  }
}

