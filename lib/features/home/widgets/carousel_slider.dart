import 'package:amazon_clone/const/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({super.key});

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(itemBuilder: (context, index) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.network(
            GlobalVariables
                .carouselImages[index % GlobalVariables.carouselImages.length],
            fit: BoxFit.fitHeight,
          ),
        );
      }),
    );
  }
}
