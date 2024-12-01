import 'package:flutter/material.dart';
import 'package:labs_project/presentation/widgets/product_card.dart';

import '../../data/models/product.dart';
import '../../data/services/api_service.dart';
import '../widgets/custom_app_bar.dart';

class GarmentsHomeScreen extends StatefulWidget {
  const GarmentsHomeScreen({super.key});

  @override
  State<GarmentsHomeScreen> createState() => _GarmentsHomeScreenState();
}

class _GarmentsHomeScreenState extends State<GarmentsHomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getProductsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(context: context, appBarText: "211066"),
          body: GridView.builder(
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
              );
            },
          )),
    );
  }

  Future<void> getProductsFromAPI() async {
    ApiService service = ApiService();
    var response = await service.getGarmentsData();

    if (response != false) {
      List<Product> fetchedProducts = (response['data'] as List)
          .map((productData) => Product.fromJson(productData))
          .toList();
      setState(() {
        products = fetchedProducts;
      });
    } else {
      setState(() {
        products = [];
      });
    }
  }
}
