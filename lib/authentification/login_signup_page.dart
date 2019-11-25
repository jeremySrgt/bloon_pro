import 'package:flutter/material.dart';
import 'package:bloon_pro/authentification/auth.dart';
import 'package:bloon_pro/services/crud.dart';
import 'package:bloon_pro/services/proData.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _passwordTextController = TextEditingController();

  CrudMethods crudObj = new CrudMethods();

  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  String _email;
  String _name;
  String _surname;
  String _phone;
  bool _userSex = true;

  int _radioValue = 0;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId;
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          if (userId == null) {
            setState(() {
              _errorMessage = "Vérifiez votre mail";
            });
          }
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.createUser(_email, _password);
          print('En attente de validation d\'email');
        }

//        if(userId == null){
//          setState(() {
//            _errorMessage = 'Verifiez votre email';
//          });
//        }

        if (userId != null && _isLoginForm) {
          print("login in");
          widget.loginCallback();
        }
        if (!_isLoginForm) {
          ProData proData = new ProData(
            name: _name,
            surname: _surname,
            mail: _email,
            notification: true,
            phone: _phone,
            picture:
                "https://firebasestorage.googleapis.com/v0/b/lynight-53310.appspot.com/o/profilePics%2Fbloon_pics.jpg?alt=media&token=ab6c1537-9b1c-4cb4-b9d6-2e5fa9c7cb46",
            sex: _userSex,
          );
          crudObj.createOrUpdateAdminData(proData.getDataMap());
          setState(() {
            _isLoginForm = true;
          });
        }

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
//          _formKey.currentState.reset();
        });
      }
    }
    _isLoading = false;
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  Widget _showCircularProgress() {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('email'),
        decoration: InputDecoration(
          labelText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Saisissez un e-mail valide';
          }
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('namefield'),
        decoration: InputDecoration(
          labelText: 'Prénom',
          icon: new Icon(
            Icons.perm_identity,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Saisissez un prénom';
          }
        },
        onSaved: (value) => _name = value,
      ),
    );
  }

  Widget _buildSurnameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('surnamefield'),
        decoration: InputDecoration(
          labelText: 'Nom',
          icon: new Icon(
            Icons.perm_identity,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Saisissez un nom';
          }
        },
        onSaved: (value) => _surname = value,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('password'),
        decoration: InputDecoration(
            labelText: 'Mot de passe',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        controller: _passwordTextController,
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return '6 caractères minimum sont requis';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _builConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirmez le mot de passe',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        obscureText: true,
        validator: (String value) {
          if (_passwordTextController.text != value) {
            return 'Le mot de passe ne correspond pas';
          }
        },
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _userSex = true;
          break;
        case 1:
          _userSex = false;
          break;
      }
    });
  }

  Widget _showGenderSelect() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.venusMars,
            color: Colors.grey,
          ),
          Radio(
            value: 0,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          Text(
            'Homme',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Radio(
            value: 1,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          Text('Femme', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        key: new Key('phonefield'),
        decoration: InputDecoration(
          labelText: 'Téléphone',
          icon: new Icon(
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Saisissez un numéro';
          }
          if (value.length < 10) {
            return 'Numéro invalide';
          }
        },
        onSaved: (value) => _phone = value,
      ),
    );
  }

  Widget _showCodeComptePro() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        obscureText: true,
        maxLines: 1,
        keyboardType: TextInputType.number,
        key: new Key('codepro'),
        decoration: InputDecoration(
          labelText: 'Code de compte Pro',
          icon: new Icon(
            Icons.verified_user,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          var bytes = utf8.encode(value);
          var digest = crypto.sha256.convert(bytes);

          if (value.isEmpty) {
            return 'Un code est requis pour créer un compte pro';
          }
          if (digest.toString() !=
              'd54123de468bd42ea00dafbd777f85fe5fa1ff6404d9838c007953c25c92a1c5') {
            print(digest);
            return 'Code invalide';
          }
          return null;
        },
      ),
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildEmailField(),
              _isLoginForm ? Container() : _buildNameField(),
              _isLoginForm ? Container() : _buildSurnameField(),
              _isLoginForm ? Container() : _buildPhoneField(),
              _buildPasswordField(),
              _isLoginForm ? Container() : _builConfirmPasswordTextField(),
              _isLoginForm ? Container() : _showGenderSelect(),
              _isLoginForm ? Container() : _showCodeComptePro(),
              _isLoading ? _showCircularProgress() : showPrimaryButton(),
              _isLoading ? Container() : showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

//  Widget showLogo() {
//    return new Hero(
//      tag: 'hero',
//      child: Padding(
//        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
//        child: CircleAvatar(
//          backgroundColor: Colors.transparent,
//          radius: 48.0,
//          child: Image.asset('assets/flutter-icon.png'),
//        ),
//      ),
//    );
//  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm
                ? 'Créer un compte '
                : 'Vous avez un compte ? Connectez-vous',
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Theme.of(context).primaryColor,
            child: new Text(_isLoginForm ? 'Connexion' : 'Créer un compte',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Bloon Pro'),
        ),
        body: _showForm());
  }
}
