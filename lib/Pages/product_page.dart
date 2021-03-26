import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Pages/product_card.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';
import 'package:simpleinterest/model/product_model.dart';

class ProductPage extends StatelessWidget {

  Widget _buildContentWidget(List<Product> products){
    Widget content;
    if(products.length > 0){
      content = ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return ProductCard(index);
        },
        itemCount: products.length,
      );
    }
    else{
      content = Container(
        child: Center(
          child: Text('No product found',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontFamily: 'AmaticSC',
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
    }
    return content;
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder : (BuildContext context,Widget child, MainModel model){
      return _buildContentWidget(model.isFavorite ? model.favouriteProduct : model.product);
    }
    );
  }
}
