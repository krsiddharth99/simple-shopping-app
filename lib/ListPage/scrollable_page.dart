import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpleinterest/ListPage/scroll_page_list.dart';
import 'package:simpleinterest/model/product_model.dart';

class ScrollableList extends StatelessWidget {
  final List<Product> productItem = scrollProductItem;
  Widget _buildListWidgetScroll(BuildContext context,int index){
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        margin: EdgeInsets.only(top:3.0,bottom: 10.0),
        width: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(productItem[index].imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              spreadRadius: -3.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.black12.withOpacity(0.0),
                  Colors.black26.withOpacity(0.2),
                  Colors.black38.withOpacity(0.3),
                  Colors.black54.withOpacity(0.5),
                ]),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 8,
                right: 4,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 17,
                right: 5,
                child: Icon(Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 17,
                left: 5,
                child: Text(productItem[index].title,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'AmaticSC',
                      fontSize: 25.0,
                      letterSpacing: 1.0
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: _buildListWidgetScroll,
      itemCount: productItem.length,
    );
  }
}
