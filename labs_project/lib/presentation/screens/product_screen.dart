import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../utils/text_styles.dart';
import '../widgets/custom_app_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final Product product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)!.settings.arguments as Product;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(context: context),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(product.picture)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.name,
                    style: StyledText()
                        .productInfoText(fontWeight: StyledText().bold),
                  ),
                  Divider(),
                  Text(
                    product.description,
                    style: StyledText().productInfoText(
                        fontWeight: StyledText().regular, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Price: \$${product.price}",
                    style: StyledText().productInfoText(fontSize: 28),
                  ),
                ],
              ),
            )));
  }
}
