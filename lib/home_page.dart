import 'package:flutter/material.dart';
import 'package:bloon_pro/authentification/auth.dart';
import 'package:bloon_pro/widget/myDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: new Text('Flutter login demo'),
        actions: <Widget>[
          new FlatButton(
            child: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white,),
            onPressed: signOut,
          )
        ],
      ),
      drawer: MyDrawer(currentPage: 'home', userId: null),
      body: Center(
        child: Text("hello bloon pro"),
      ),
    );
  }
}
