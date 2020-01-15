import 'package:flutter/material.dart';
import 'package:bloon_pro/widget/myDrawer.dart';
import 'package:bloon_pro/services/crud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'scannerQrCode.dart';

class ClubToScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClubToScanState();
  }
}

class _ClubToScanState extends State<ClubToScan> {
  List<dynamic> _clubList = [];
  List<Map<dynamic, dynamic>> _clubsData = [];

  bool _isLoading = false;

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  CrudMethods crudObj = new CrudMethods();

  Future<dynamic> _refresh() {
    return crudObj.getDataFromAdminFromDocument().then((value) {
      setState(() {
        _clubList = value.data['myClubs'];
        _isLoading = true;
      });

      List<Map<dynamic, dynamic>> tempList = [];
      for (int i = 0; i < _clubList.length; i++) {
        //peut etre qu'il faudrait utiliser le refreshcontroller.toidle() pour pas avoir de setState et se servir de l'animation de chargement asynchrone
        setState(() {
          _isLoading = true;
        });
        crudObj.getDataFromClubFromDocumentWithID(_clubList[i]).then((value) {
          Map<String, dynamic> map = value.data;
          map["clubId"] = _clubList[i];
          tempList.add(map);
          setState(() {
            _isLoading= false;
          });
        });
      }

      setState(() {
        _clubsData = tempList;
      });

      _refreshController.refreshCompleted();
    });
  }

  Future<dynamic> _onLoading() {
    return crudObj.getDataFromAdminFromDocument().then((value) {
      setState(() {
        _clubList = value.data['myClubs'];
        _isLoading = true;
      });

      List<Map<dynamic, dynamic>> tempList = [];
      for (int i = 0; i < _clubList.length; i++) {
        setState(() {
          _isLoading = true;
        });
        crudObj.getDataFromClubFromDocumentWithID(_clubList[i]).then((value) {
          Map<String, dynamic> map = value.data;
          map["clubId"] = _clubList[i];
          tempList.add(map);
          setState(() {
            _isLoading = false;
          });
        });
      }

      setState(() {
        _clubsData = tempList;
      });


      _refreshController.loadComplete();
    });
  }

  Widget _listConstruct(index) {
    return ListTile(
      title: Text(_clubsData[index]['name']),
      trailing: Icon(FontAwesomeIcons.qrcode),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ScannerQrCode(clubId: _clubsData[index]['clubId'], clubName : _clubsData[index]['name'] )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(currentPage: 'scanner', userId: null,),
      appBar: AppBar(
        title: Text("Scanner QR code"),
      ),
      body: SmartRefresher(
          header: BezierCircleHeader(),
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _refresh,
          child: _isLoading
              ? Container()
              : ListView.builder(
            itemCount: _clubList.length,
            itemBuilder: (context, index) {
              return _listConstruct(index);
            },
          )),
    );
  }
}
