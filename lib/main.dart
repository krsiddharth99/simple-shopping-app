import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Authentication/auth_page.dart';
import 'package:simpleinterest/Manager/manage_product.dart';
import 'package:simpleinterest/Manager/product_manager.dart';
import 'package:simpleinterest/Pages/product_detail.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';
import 'package:simpleinterest/model/product_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    return ScopedModel(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cosmetic Product',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3.0,
                  color: Colors.black,
                ),
              ),
              unselectedLabelColor: Colors.black38),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 35.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'AmaticSc',
                letterSpacing: 2.0,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 18,
          ),
        ),
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/ProductManager': (BuildContext context) =>
              ProductManager(model),
          '/ManageProduct': (BuildContext context) =>
              ManageProduct(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> productItem = settings.name.split('/');
          if (productItem[0] != '') {
            return null;
          }
          if (productItem[1] == 'product') {
            final String productId = productItem[2];
            /*  ......  model.selectedProductId(productId); ...............
            * If we continue with this approach of navigating to product detail page
            * this will make Create page as Edit page because we select the product here but actually we don't want to do that
            * so for that reason we use the approach with suits here below.*/
            final Product product = model.product.firstWhere((Product productGet) {
              return productGet.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductDetail(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductManager(model),
          );
        },
      ),
    );
  }
}
