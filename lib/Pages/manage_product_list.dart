import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Pages/create_product.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';
import 'package:simpleinterest/model/product_model.dart';

class ManageProductList extends StatefulWidget {
  final MainModel model;
  ManageProductList(this.model);
  @override
  _ManageProductListState createState() => _ManageProductListState();
}

class _ManageProductListState extends State<ManageProductList> {

  @override
  initState(){
    print('manageproductlist fetch');
    widget.model.fetchData();
    super.initState();
  }
  Widget _buildListPage(BuildContext context, List<Product> productItem) {
    Widget resultPage;
    if (productItem.length > 0) {
      resultPage = ListView.builder(
        itemCount: productItem.length,
        itemBuilder: (BuildContext context, int index) {
          return ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget child, MainModel model) {
            return Dismissible(
              background: Container(
                color: Colors.red[900],
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 23.0,
                  ),
                ),
              ),
              key: Key(productItem[index].title),
              onDismissed: (DismissDirection direction) {
                if (DismissDirection.endToStart == direction) {
                  model.selectedProductId(model.product[index].id);
                  model.deleteProduct();
                }
              },
              child: Column(
                children: <Widget>[
                  SizedBox(height: 4.0),
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                        AssetImage(productItem[index].imageUrl),
                        radius: 30,
                      ),
                      title: Text(
                        productItem[index].title,
                        style: TextStyle(
                          color: Colors.pink[900],
                          fontSize: 23.0,
                          fontFamily: 'AmaticSC',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                        ),
                      ),
                      subtitle: Text(
                        productItem[index].price.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'AmaticSC',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 23.0,
                      ),
                      onTap: () {
                        model.selectedProductId(model.product[index].id);
                        print(model.selectedProductIndex);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CreateProduct(),
                          ),
                        );
                      }),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Colors.black38,
                  ),
                ],
              ),
            );
          });
        },
      );
    } else {
      resultPage = Container(
        child: Center(
          child: Text(
            'No product found',
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
    return resultPage;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildListPage(context, model.product);
      },
    );
  }
}
