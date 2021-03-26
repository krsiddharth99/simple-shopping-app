import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simpleinterest/model/product_model.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Product Detail'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(product.imageUrl),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(
                        color: Colors.pink[900],
                        fontSize: 45.0,
                        fontFamily: 'AmaticSC',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    height: 50.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 1.2,
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$${product.price.toString()}',
                        style: TextStyle(
                          color: Colors.pink[900],
                          fontSize: 20.0,
                          fontFamily: 'AmaticSC',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                height: 30.0,
                width: 260.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    width: 1.2,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Lucknow, Uttar Pradesh, India',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'AmaticSC',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    /*
    .....Since Scope model here for no reason because we already taken a value through constructor......
    ....................................................................................................
      ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product product = model.selectedProduct;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Product Detail'),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(product.imageUrl),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: TextStyle(
                            color: Colors.pink[900],
                            fontSize: 45.0,
                            fontFamily: 'AmaticSC',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0),
                      ),
                      SizedBox(width: 15.0),
                      Container(
                        height: 50.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 1.2,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '\$${product.price.toString()}',
                            style: TextStyle(
                              color: Colors.pink[900],
                              fontSize: 20.0,
                              fontFamily: 'AmaticSC',
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 30.0,
                    width: 260.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        width: 1.2,
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Lucknow, Uttar Pradesh, India',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'AmaticSC',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      */
