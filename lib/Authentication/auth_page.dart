import 'package:flutter/material.dart';
import 'file:///D:/SimpleInterest/simple_interest/lib/Manager/product_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _infoData = {
    'id': null,
    'email': null,
    'password': null,
  };

  void onSaved(Function login) {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    login(_infoData['email'],_infoData['password']);
    Navigator.pushReplacementNamed(context,'/ProductManager');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100.0, left: 15.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value.trim().length <= 0) {
                    return 'Email should be entered and must be greater than 5';
                  }
                  return null;
                },
                onSaved: (value) {
                  _infoData['email'] = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value.trim().length <= 0 || value.trim().length < 5) {
                    return 'Password should be entered and must be greater than 5';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _infoData['password'] = value;
                },
              ),
              SizedBox(height: 20),
              ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child,MainModel model){
                return ButtonBar(
                  children: <Widget>[
                    InkWell(
                      child: Center(
                        child: Text(
                          'Sign-up',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 23.0,
                              fontFamily: 'AmaticSC',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    FlatButton(
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => onSaved(
                        model.login
                      ),
                      child: Container(
                        height: 42,
                        width: 80,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 23.0,
                                fontFamily: 'AmaticSC',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
