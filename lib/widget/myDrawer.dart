import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bloon_pro/main.dart';
import 'package:bloon_pro/services/crud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({@required this.currentPage, this.userId});

  final String currentPage;
  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _MyDrawerState();
  }
}

class _MyDrawerState extends State<MyDrawer> {
  CrudMethods crudObj = new CrudMethods();
  Map<String, dynamic> dataMap = {};

  @override
  void initState() {
    super.initState();

    crudObj.getDataFromAdminFromDocument().then((value) {
      setState(() {
        dataMap = value.data;
      });
    });
  }

  Widget _showShimmerLoading() {
    return Container(
        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 10.0),
//        width: 200.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
//              // photo de profil
                  backgroundColor: Colors.black54,
                  minRadius: 25,
                  maxRadius: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _headerContent() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            // photo de profil
            backgroundImage: NetworkImage(dataMap['picture']),
            minRadius: 25,
            maxRadius: 25,
          ),
          title: Text(
            "Bonjour",
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(
            dataMap["name"],
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        ListTile(
          title: Text(dataMap["mail"]),
        ),
      ],
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: dataMap.isEmpty ? _showShimmerLoading() : _headerContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentDrawer = Provider.of<DrawerStateInfo>(context).getCurrentDrawer;
    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(),
          Container(
            decoration: currentDrawer == 0
                ? BoxDecoration(
                    color: Color(0xFFebdffc),
                    borderRadius: BorderRadius.circular(15.0))
                : BoxDecoration(),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: currentDrawer == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(
                "Accueil",
                style: currentDrawer == 0
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor)
                    : TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (widget.currentPage == "home") return;

                Provider.of<DrawerStateInfo>(context).setCurrentDrawer(0);

                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ),
          Container(
            decoration: currentDrawer == 1
                ? BoxDecoration(
                    color: Color(0xFFebdffc),
                    borderRadius: BorderRadius.circular(15.0))
                : BoxDecoration(),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.solidUserCircle,
                color: currentDrawer == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(
                "Profil",
                style: currentDrawer == 1
                    ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).primaryColor)
                    : TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (widget.currentPage == "adminProfil") return;

                Provider.of<DrawerStateInfo>(context).setCurrentDrawer(1);

                Navigator.pushReplacementNamed(context, "/adminProfil");
              },
            ),
          ),

          Container(
            decoration: currentDrawer == 2
                ? BoxDecoration(
                color: Color(0xFFebdffc),
                borderRadius: BorderRadius.circular(15.0))
                : BoxDecoration(),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.glassCheers,
                color: currentDrawer == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(
                "Mes Clubs",
                style: currentDrawer == 2
                    ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).primaryColor)
                    : TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (widget.currentPage == "myclubs") return;

                Provider.of<DrawerStateInfo>(context).setCurrentDrawer(2);

                Navigator.pushReplacementNamed(context, "/myClubs");
              },
            ),
          ),
          Container(
            decoration: currentDrawer == 3
                ? BoxDecoration(
                color: Color(0xFFebdffc),
                borderRadius: BorderRadius.circular(15.0))
                : BoxDecoration(),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.qrcode,
                color: currentDrawer == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(
                "Scanner QR",
                style: currentDrawer == 3
                    ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).primaryColor)
                    : TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (widget.currentPage == "scanner") return;

                Provider.of<DrawerStateInfo>(context).setCurrentDrawer(3);

                Navigator.pushReplacementNamed(context, "/clubToScan");
              },
            ),
          ),
        ],
      ),
    );
  }
}
