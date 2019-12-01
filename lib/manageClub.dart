import 'package:flutter/material.dart';
import 'package:bloon_pro/services/crud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageClub extends StatefulWidget {
  ManageClub({@required this.clubId, @required this.clubName});

  final String clubId;
  final String clubName;

  @override
  State<StatefulWidget> createState() {
    return _ManageClubState();
  }
}

class _ManageClubState extends State<ManageClub> {
  CrudMethods crudObj = new CrudMethods();
  final _formKey = GlobalKey<FormState>();
  final _placeFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Widget _clubNameField(clubData) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.compactDisc,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        "Nom de la boite",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String _name;
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
                            decoration:
                                InputDecoration(hintText: 'Nom de la boite'),
                            onSaved: (value) => _name = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Text(
                              "Valider",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                crudObj.updateCLubDataWithId(
                                    {'name': _name}, widget.clubId);
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
        clubData['name'],
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget _clubAdressField(clubData) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.mapMarkedAlt,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        "Adresse",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String _adress;
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
                            decoration: InputDecoration(hintText: 'Adresse'),
                            onSaved: (value) => _adress = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Text(
                              "Valider",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                crudObj.updateCLubDataWithId(
                                    {'adress': _adress}, widget.clubId);
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
        clubData['adress'],
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  String validatePhone(String value) {
    if (value.length != 10)
      return 'Veuillez entrer un numéro valide';
    else
      return null;
  }

  Widget _clubPhoneField(clubData) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.phone,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        "Téléphone",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String _phone;
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Téléphone'),
                            onSaved: (value) => _phone = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Text(
                              "Valider",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                crudObj.updateCLubDataWithId(
                                    {'phone': _phone}, widget.clubId);
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
        clubData['phone'],
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget _clubSiteUrlField(clubData) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.sitemap,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        "Site web",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String _site;
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
                            decoration: InputDecoration(hintText: 'Site Web'),
                            onSaved: (value) => _site = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Text(
                              "Valider",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                crudObj.updateCLubDataWithId(
                                    {'siteUrl': _site}, widget.clubId);
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
        clubData['siteUrl'],
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget _pageConstruct(clubData) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _clubNameField(clubData),
          _clubAdressField(clubData),
          _clubPhoneField(clubData),
          _clubSiteUrlField(clubData)
        ],
      ),
    );
  }

  String validatePlaceForm(String value) {
    if (value.length == 0)
      return 'Veuillez saisir une valeur';
    else
      return null;
  }

  int _placesPrice;
  int _numberOfPlaces;

  void addPlaceToClub(numberOfPlace, placePrice) async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> placeInfo = {"price": _placesPrice};
    for (int i = 0; i < numberOfPlace; i++) {
      print("dans le for $i");
      Firestore.instance
          .collection('club')
          .document(widget.clubId)
          .collection('placesDispo')
          .add(placeInfo);
    }

    Future.delayed(const Duration(seconds: 2),(){

      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _showAddPlacesToClub() {
    return Column(
      children: <Widget>[
        Form(
          key: _placeFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: validatePlaceForm,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Nombre de places'),
                onSaved: (value) => _numberOfPlaces = int.parse(value),
              ),
              TextFormField(
                validator: validatePlaceForm,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Prix unitaire'),
                onSaved: (value) => _placesPrice = int.parse(value),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: _isLoading
              ? CircularProgressIndicator()
              : RaisedButton(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text(
                    "Valider les places",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_placeFormKey.currentState.validate()) {
                      _placeFormKey.currentState.save();
                      addPlaceToClub(_numberOfPlaces, _placesPrice);
                      _placeFormKey.currentState.reset();
                    }
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gestion de " + widget.clubName),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('club')
              .document(widget.clubId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            var clubData = snapshot.data;
            return Column(
              children: <Widget>[
                _pageConstruct(clubData),
                _showAddPlacesToClub()
              ],
            );
          },
        ));
  }
}
