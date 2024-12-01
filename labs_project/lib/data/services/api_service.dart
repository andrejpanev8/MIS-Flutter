import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labs_project/utils/image_constants.dart';

class ApiService {
  var garmentsData = '''{
  "data": [
    {
      "id": 1,
      "picture": "$nike_trousers",
      "name": "Nike Trousers",
      "description": "Comfortable and stylish Nike Trousers for daily wear.",
      "price": 39.99
    },
    {
      "id": 2,
      "picture": "$nike_hoodie",
      "name": "Nike Hoodie",
      "description": "Warm and durable hoodie, perfect for all seasons.",
      "price": 49.99
    },
    {
      "id": 3,
      "picture": "$nike_fleece",
      "name": "Nike Fleece",
      "description": "Soft fleece jacket to keep you cozy and comfortable.",
      "price": 59.99
    },
    {
      "id": 4,
      "picture": "$nike_hoodie2",
      "name": "Nike Hoodie 2",
      "description": "Trendy washed fleece hoodie for a casual yet modern look.",
      "price": 55.49
    },
    {
      "id": 5,
      "picture": "$nike_shirt",
      "name": "Nike Shirt",
      "description": "Classic Nike shirt designed for both comfort and style.",
      "price": 29.99
    },
    {
      "id": 6,
      "picture": "$nike_jordan_shirt",
      "name": "Nike Jordan Shirt",
      "description": "Stylish Jordan shirt for sports or casual outings.",
      "price": 35.99
    },
    {
      "id": 7,
      "picture": "$nike_jordan_tee",
      "name": "Nike Jordan Tee",
      "description": "Lightweight tee with iconic Jordan design for ultimate comfort.",
      "price": 22.99
    },
    {
      "id": 8,
      "picture": "$nike_jordan_tee",
      "name": "Nike Jordan Tee Additional Filler",
      "description": "Lightweight tee with iconic Jordan design for ultimate comfort. Additional Filler",
      "price": 23.99
    },
    {
      "id": 9,
      "picture": "$nike_jordan_tee",
      "name": "Nike Jordan Tee Additional Filler 2",
      "description": "Lightweight tee with iconic Jordan design for ultimate comfort. Additional Filler 2",
      "price": 24.99
    }
  ]
}''';

  Future<dynamic> getGarmentsData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      return json.decode(garmentsData);
    } on Exception catch (err) {
      debugPrint("Get garments data error: $err");
      return false;
    }
  }
}
