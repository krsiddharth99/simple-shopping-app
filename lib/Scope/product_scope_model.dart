import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/model/product_model.dart';
import 'package:simpleinterest/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConnectedScopeModel extends Model {
  User _authenticatedUser;
  List<Product> _products = [];
  String _selectedProductId;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  Future<bool> addProduct(
      String title, String description, double price, String imageUrl) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> products = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
    try{
      /* We used this try and catch method because there is no other way of handle CatchError method
      * as compared to '.then((http.response response){..some code..}).catchError((error){..some code..});'
      * instead we use this in build try catch method which is default and follow the same approach.
      * This way as well as previous one both works the same but it is more understanding that's why I leave the
      * other method as it is... */
      final http.Response response = await http.post(

         /* here http.post(); method returns the response which is received by 'Response' type variable 'response'
          * previously we are doing the same in '.then((http.Response response){...});' but now after using async
          * method with await we have to store it in variable locally........ */

          'https://cosmeticproducts-52113.firebaseio.com/products.json',

          /* post() method required url and body where URL given by firebase 'https://cosmeticproducts-52113.firebaseio.com'
           * and that 'products.json' I added to make products type section in data base and used as API to target product
           * section there while '.json' is added because we always store data in database in the form of json(Key and Values)
           * so we parse data in json for data base. */

          body: json.encode(products));

          /* previously we talk about URL now it time to get to know about 'body' section. in body we have to pass the data
          * and should be of json type for that we used 'json.encode(...)' in this encode() function we have to pass data
          * which is of type key and value(Map<String, dynamic>) for that reason i used Map here and then later convert with flutter
          * converter package */

      if (response.statusCode != 200 && response.statusCode != 201) {
        /* 200 and 201 is a error code means that something went wrong */
        _isLoading = false;
        notifyListeners();
        return false;
        /* This will send unsuccessful attempt due to error in status code 'return false'*/
      }

      final Map<String, dynamic> id = json.decode(response.body);

      /*  whatever the response we get from the http.post() we store in variable of Response type this variable contain 'body'
       *  which we can access through response.body since it was in the form of json and we convert it using decoder
       * 'json.decode(response.body)' and stored it in Map<String,dynamic> variable because map contain values as (key and value) type
       * and later update our local List<Product> through this.  */

      final Product product = Product(
        id: id['name'],
        title: title,
        price: price,
        description: description,
        imageUrl: imageUrl,
        userEmail: _authenticatedUser.userEmail,
        userId: _authenticatedUser.id,
      );
      _products.add(product);
      _isLoading = false;
      notifyListeners();
      return true; /* This will tell that code runs fine and no error found and proceed */
    }catch(error){  /* Once the error thrown catch will get this and perform the code in it */
      _isLoading =false;
      notifyListeners();
      return false;
    }
    /*----- .catchError((error){    /*This Catch error helps to detect any kind of error even status code also and suitable way of handling error*/
      ----     _isLoading =false;
      ----     notifyListeners();
      ----     return false;
      ----  });
     */
  }
}

class ProductScopeModel extends ConnectedScopeModel {

  bool _isFavorite = false; /* to toggle between displays favourite and not favourite product and initially make it false*/

  bool get isFavorite {
    /* Getter is the new concept like pointers we can use private member outside the class by not changing
    * the original value directly. here we want to toggle between two display in product manager page but
    * by using(model._isFavorite) through an error we can't directly access that item so for that reason we use
    * getter here that whenever it's required to use that local private variable outside the class we ca do
    * it using this new concept */
    return _isFavorite;
  }

  String get selectiveId {
    return _selectedProductId;
  }

  List<Product> get favouriteProduct {
    if (_isFavorite) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  List<Product> get product {
    return List.from(_products);
  }

  Product get selectedProduct {
    if (selectiveId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  void toggleDisplay() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void selectedProductId(String id) {
    _selectedProductId = id;
    notifyListeners();
  }

  Future<bool> updateProduct(
      String title, String description, double price, String imageUrl) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateProducts = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };
    return http
        .put(
            'https://cosmeticproducts-52113.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateProducts))
        .then((http.Response response) {
      _isLoading = false;
      final Product product = Product(
        id: selectedProduct.id,
        title: title,
        price: price,
        description: description,
        imageUrl: imageUrl,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.id,
      );
      /*  _products.indexWhere((Product product) {
              return product.id == _selectedProductId;
          });
      */
      _products[selectedProductIndex] = product;
      notifyListeners();
      return true;
      print('update product' + selectedProductIndex.toString());
    }).catchError((error) {
      /*This Catch error helps to detect any kind of error even status code also and suitable way of handling error*/
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    /* Keep in mind we changed this from Void to Future<bool> for CatchError method*/
    _isLoading = true;
    final String deleteProductId = selectedProduct.id;
    /*  _products.indexWhere((Product product) {
              return product.id == _selectedProductId;
          });
    */
    _products.removeAt(selectedProductIndex);
    _selectedProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://cosmeticproducts-52113.firebaseio.com/products/${deleteProductId}.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      /*This Catch error helps to detect any kind of error even status code also and suitable way of handling error*/
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchData() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://cosmeticproducts-52113.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      /* Here we make then Null to make sure it will not through any error*/
      final List<Product> _fetchListData = [];
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      if (fetchedData == null) {

        /* we used this block here because suppose we call for fetching data but there is no data there in the
        * database at that moment our logic to stop spinner and making _isLoading false goes wrong. So to overcome this
        * issue we here check whether that the response we received from the database is 'null' or not because if there
        * is no data in the database it will return 'null' otherwise return data in the form of key and value.  */

        _isLoading = false;
        notifyListeners();
        return;
        /* Here in comparison with other Future<bool>
       * we used Future<Null> because refresh indicator works only
       *  on Null not on any other parameters.*/
      }
      fetchedData.forEach((String id, dynamic product) {
        final Product productData = Product(
          id: id,
          title: product['title'],
          price: product['price'],
          description: product['description'],
          imageUrl: product['imageUrl'],
          userEmail: product['userEmail'],
          userId: product['userId'],
        );
        _fetchListData.add(productData);
      });
      _products = _fetchListData;
      _isLoading = false;
      notifyListeners();
      _selectedProductId = null;
      print('fetch product' + selectedProductIndex.toString());
    }).catchError((error) {
      /*This Catch error helps to detect any kind of error even status code also and suitable way of handling error*/
      _isLoading = false;
      notifyListeners();
      return;
      /* Here in comparison with other Future<bool>
       * we used Future<Null> because refresh indicator works only
       *  on Null not on any other parameters.*/
    });
  }

  void toggleFavouriteProduct() {
    /*  _products.indexWhere((Product product) {
              return product.id == _selectedProductId;
          });
    */
    final bool currentFavouriteStatus =
        _products[selectedProductIndex].isFavorite;
    final bool newFavourite = !currentFavouriteStatus;
    final Product newProduct = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      price: selectedProduct.price,
      description: selectedProduct.description,
      imageUrl: selectedProduct.imageUrl,
      userId: selectedProduct.userId,
      userEmail: selectedProduct.userEmail,
      isFavorite: newFavourite,
    );
    _products[selectedProductIndex] = newProduct;
    _selectedProductId = null;
    notifyListeners();
  }
}

class UserScopeModel extends ConnectedScopeModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: 'hcdchadgchdgchd', userEmail: email, password: password);
  }
}
