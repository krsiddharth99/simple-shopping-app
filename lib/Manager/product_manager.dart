import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Pages/product_page.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';

class ProductManager extends StatefulWidget {
  final MainModel model;
  ProductManager(this.model);
  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Choose'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(
              Icons.list,
              size: 23.0,
            ),
            title: Text(
              'Manage Product',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontFamily: 'AmaticSC',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0),
            ),
            trailing: Icon(
              Icons.arrow_right,
              size: 23.0,
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/ManageProduct'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  Widget _buildProductPage(){
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child,MainModel model){
      Widget content = Container(
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
      if(model.product.length > 0 && !model.isLoading){
        content = ProductPage();
      }
      else if(model.isLoading){
        content = Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.pink[900]),
          ),
        );
      }
      return RefreshIndicator(child: content,onRefresh: model.fetchData,color: Colors.pink[900]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Product Manager'),
        centerTitle: true,
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder:
                (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(
                  model.isFavorite ? Icons.favorite_border : Icons.favorite,
                  color: Colors.pink[900],
                ),
                onPressed: () {
                  model.toggleDisplay();
                },
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildProductPage(),
          ),
        ],
      ),
    );
  }
}
