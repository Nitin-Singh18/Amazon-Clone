import 'package:flutter/material.dart';

import '../../../common/widgets/rating-widget.dart';
import '../../../models/product.dart';
import '../../../models/rating.dart';
import '../../../providers/user_provider.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  double avgRating = 0;
  void fetchRating(context) {
    double totalRating = 0;

    debugPrint(product.rating!.length.toString());
    for (int i = 0; i < product.rating!.length; i++) {
      Rating element = product.rating![i];
      totalRating += element.rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchRating(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
