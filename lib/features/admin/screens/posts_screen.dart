import 'package:amazon_clone/features/account/widgets/product_tile.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? productsList = [];
  final AdminServices _adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    print("working");
    fetchAllProducts();
    super.initState();
  }

  fetchAllProducts() async {
    productsList = await _adminServices.fetchAllProducts(context);
    print(productsList);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminServices.deleteProduct(context, product, () {
      productsList!.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return productsList == null
        ? const CircularProgressIndicator()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: productsList!.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = productsList![index];
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 140,
                        child: ProductTile(productImage: product.images[0]),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  deleteProduct(product, index);
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  size: 24,
                                ))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              tooltip: "Add a product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
