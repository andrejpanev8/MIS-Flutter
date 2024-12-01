import 'package:flutter/material.dart';

import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: product);
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: Center(child: Image.network(product.picture))),
            SizedBox(
              height: 5,
            ),
            Text(product.name),
            Divider(),
            Text(
              product.description,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text("Price: \$${product.price}"),
          ],
        ),
      ),
    );
  }
}
