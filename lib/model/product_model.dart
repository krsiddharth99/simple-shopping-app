import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  final String userEmail;
  final String userId;
  final bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.imageUrl,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite =false,
  });
}
