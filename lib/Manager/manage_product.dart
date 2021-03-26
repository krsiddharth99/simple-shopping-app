import 'package:flutter/material.dart';
import 'package:simpleinterest/Pages/create_product.dart';
import 'package:simpleinterest/Pages/manage_product_list.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';

class ManageProduct extends StatelessWidget {
  final MainModel model;
  ManageProduct(this.model);

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
              'All Product',
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
                Navigator.pushReplacementNamed(context, '/ProductManager'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Product'),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.create),
              text: 'Create Product',
            ),
            Tab(
              icon: Icon(Icons.email),
              text: 'Manage Product List',
            ),
          ]),
        ),
        drawer: _buildDrawer(context),
        body: TabBarView(
          children: [
            CreateProduct(),
            ManageProductList(model),
          ],
        ),
      ),
    );
  }
}
