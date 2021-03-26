import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Scope/mainmodel.dart';

class ProductCard extends StatelessWidget {
  final int productIndex;
  ProductCard(this.productIndex);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (
        BuildContext context, Widget child, MainModel model)
    {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(model.product[productIndex].imageUrl),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  model.product[productIndex].title,
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
                      '\$${model.product[productIndex].price.toString()}',
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
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.info,
                    size: 32.0,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed<bool>(
                        context, '/product/' + model.product[productIndex].id,
                      )
                ),
                IconButton(
                  icon: Icon(
                    model.product[productIndex].isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 32.0,
                    color: Colors.pink[900],
                  ),
                  onPressed: () {
                    model.selectedProductId(model.product[productIndex].id);
                    model.toggleFavouriteProduct();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
