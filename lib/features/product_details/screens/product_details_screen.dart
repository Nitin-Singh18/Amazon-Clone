import 'package:amazon_clone/common/widgets/c_button.dart';
import 'package:amazon_clone/common/widgets/rating-widget.dart';
import 'package:amazon_clone/features/home/widgets/carousel_slider.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/rating.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../const/global_variables.dart';
import '../../search/screen/search_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices _productDetailServices = ProductDetailServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    fetchRating();
  }

  void fetchRating() {
    double totalRating = 0;
    final String userId = context.read<UserProvider>().user.id;
    debugPrint(widget.product.rating!.length.toString());
    for (int i = 0; i < widget.product.rating!.length; i++) {
      Rating element = widget.product.rating![i];
      totalRating += element.rating;
      if (element.userId == userId) {
        myRating = element.rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() async {
    await _productDetailServices.addToCart(context, widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                onFieldSubmitted: (value) => Navigator.pushNamed(
                    context, SearchScreen.routeName,
                    arguments: value),
                decoration: const InputDecoration(
                  prefixIcon: InkWell(
                    // onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: 10),
                  hintText: "Search Amazon.in",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.mic,
                color: Colors.black,
                size: 25,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text(widget.product.name),
            ),
            CarouselSlider(
              images: widget.product.images,
            ),
            Container(
              height: 5,
              color: Colors.black12,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black),
                children: [
                  const TextSpan(text: "Deal Price: "),
                  TextSpan(
                    text: "\$${widget.product.price.toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),
            Text(widget.product.description),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(title: "Buy Now", ontap: () {}),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                title: "Add to Cart",
                ontap: () {
                  addToCart();
                },
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the Product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                _productDetailServices.rateproduct(
                    context, rating, widget.product.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
