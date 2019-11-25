import 'package:flutter/material.dart';
import 'package:bloon_pro/authentification/auth.dart';
import 'package:bloon_pro/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'selectProfilePicture.dart';
import 'package:bloon_pro/widget/myDrawer.dart';

class AdminProfil extends StatefulWidget {

  final BaseAuth auth = new Auth();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminProfilState();
  }
}

class _AdminProfilState extends State<AdminProfil> {
  String userId = 'userId';
  CrudMethods crudObj = new CrudMethods();
  String userMail = 'userMail';

  String _phoneNumber;
  String _name;
  String _surname;

  bool _notificationValue = true;

  final _formKey = GlobalKey<FormState>();

  void _onChangedNotification(bool value) {
    setState(() {
      _notificationValue = value;
    });
    crudObj.createOrUpdateAdminData({'notification': _notificationValue});
  }

  void initState() {
    super.initState();
    widget.auth.currentUser().then((id) {
      setState(() {
        userId = id;
      });
    });
    widget.auth.userEmail().then((mail) {
      setState(() {
        userMail = mail;
      });
    });

    crudObj.getDataFromAdminFromDocument().then((value) {
      // correspond à await Firestore.instance.collection('user').document(user.uid).get();
      Map<String, dynamic> dataMap = value
          .data; // retourne la Map des donné de l'utilisateur correspondant à uid passé dans la methode venant du cruObj
      setState(() {
        _notificationValue = dataMap['notification'];
      });
    });
  }

  void _openModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF737373)),
              color: Color(0xFF737373),
            ),
            child: Container(
              child: SelectProfilPicture(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
            ),
          );
        });
  }

  String validateEmail(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Saisissez un e-mail valide';
    } else
      return null;
  }

  String validatePhone(String value) {
    if (value.length != 10)
      return 'Veuillez entrer un numéro valide';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
      Firestore.instance.collection('AdminBoite').document(userId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        var userData = snapshot.data;
        return pageConstruct(userData, context);
      },
    );
  }

  Widget userInfoTopSection(userData) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromRGBO(212, 63, 141, 1),
                width: 6,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                _openModalBottomSheet(context);
              },
              child: CircleAvatar(
                // photo de profil
                backgroundImage: NetworkImage(userData['picture']),
                minRadius: 30,
                maxRadius: 93,
              ),
            ),
          ),
          Container(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.white,
      height: 15,
      indent: 70,
    );
  }

  Widget userBottomSection(userData) {

    Widget name() {
      return ListTile(
        leading: Icon(
          Icons.person,
          color: Colors.white,
          size: 35,
        ),
        title: Text(
          "Prénom",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Prénom'),
                              onSaved: (value) => _name = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              child: Text("Valider", style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  crudObj
                                      .createOrUpdateAdminData({'name': _name});
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        subtitle: Text(
          userData['name'],
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget surname() {
      return ListTile(
        leading: Icon(
          Icons.supervisor_account,
          color: Colors.white,
          size: 35,
        ),
        title: Text(
          "Nom",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Nom'),
                              onSaved: (value) => _surname = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              child: Text("Valider", style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  crudObj.createOrUpdateAdminData(
                                      {'surname': _surname});
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        subtitle: Text(
          userData['surname'],
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      );
    }

    Widget mail() {
      return ListTile(
        leading: Icon(
          Icons.mail,
          color: Colors.white,
          size: 35,
        ),
        title: Text(
          'Mail',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        subtitle: Text(
          userMail,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      );
    }

    Widget phone() {
      return ListTile(
        leading: Icon(
          Icons.phone,
          color: Colors.white,
          size: 35,
        ),
        title: Text(
          "Numéro",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: validatePhone,
                              decoration: InputDecoration(
                                  hintText: 'Numéro de téléphone'),
                              keyboardType: TextInputType.number,
                              onSaved: (value) => _phoneNumber = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              child: Text("Valider", style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  crudObj.createOrUpdateAdminData(
                                      {'phone': _phoneNumber});
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        subtitle: Text(
          userData['phone'],
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      );
    }


    Widget notification() {
      return ListTile(
        leading: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 35,
        ),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        trailing: Switch(
          value: _notificationValue, onChanged: _onChangedNotification,activeColor: Colors.lightBlueAccent,),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: FractionalOffset.center,
                    width: 390,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(212, 63, 141, 1),
                                  Color.fromRGBO(2, 80, 197, 1)
                                ]),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.0, 5.0),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    name(),
                                    divider(),
                                    surname(),
                                    divider(),
                                    mail(),
                                    divider(),
                                    phone(),
                                    divider(),
                                    notification(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pageConstruct(userData, context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(currentPage: 'adminProfil'),
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            flexibleSpace: FlexibleSpaceBar(
              title: userData['name'] == ""
                  ? Text(userMail)
                  : Text(
                userData['name'] + ' ' + userData['surname'],
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: userInfoTopSection(userData),
                ),
                Container(
                  child: userBottomSection(userData),
                ),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
