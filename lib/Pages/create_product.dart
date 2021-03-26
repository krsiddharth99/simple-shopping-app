import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';
import 'package:simpleinterest/model/product_model.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'description': null,
    'imageUrl': 'assets/image/map.jpg',
  };

  Widget _buildTitleField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: product == null ? '' : product.title,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
        labelText: 'Title',
      ),
      validator: (String value) {
        if (value.trim().length <= 0) {
          return 'Title should be given';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: product == null ? '' : product.description,
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
        labelText: 'Description',
      ),
      validator: (String value) {
        if (value.trim().length <= 0 || value.trim().length < 10) {
          return 'Description should be entered and must be greater than 10';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
        labelText: 'Price',
      ),
      validator: (String value) {
        if (value.trim().length <= 0 ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price should be entered and must be a number';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildMainBody(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(25.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTitleField(product),
              SizedBox(height: 20),
              _buildDescriptionField(product),
              SizedBox(height: 20),
              _buildPriceField(product),
              SizedBox(height: 20.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        print('build submit scope ' + model.selectedProductIndex.toString());
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pink[900]),
                ),
              )
            : FlatButton(
                color: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  onSaved(model.addProduct, model.updateProduct,
                      model.selectedProductId, model.selectedProductIndex);
                },
                child: Container(
                  height: 42,
                  width: 80,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 23.0,
                          fontFamily: 'AmaticSC',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void onSaved(
      Function addProduct, Function updateProduct, Function selectProductId,
      [int selectProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['price'],
        _formData['imageUrl'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/ProductManager').then(
            (_) => selectProductId(null),
          );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Warning Error found',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 28.0,
                      fontFamily: 'AmaticSC',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    'You can try again',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontFamily: 'AmaticSC',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0),
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 42,
                        width: 80,
                        child: Center(
                          child: Text(
                            'Okay',
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
              });
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['price'],
        _formData['imageUrl'],
      ).then(
        (_) => Navigator.pushReplacementNamed(context, '/ProductManager').then(
          (_) => selectProductId(null),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildMainBody(context, model.selectedProduct);
        print('create product build' + model.selectedProductIndex.toString());
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: pageContent);
      },
    );
  }
}
