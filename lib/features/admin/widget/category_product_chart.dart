import 'package:amazon_clone/features/admin/model/sales_model.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sales> data;
  const CategoryProductChart({super.key, required this.data});

  @override
  State<CategoryProductChart> createState() => _CategoryProductChartState();
}

class _CategoryProductChartState extends State<CategoryProductChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(), // Define x-axis as categorical
      series: <CartesianSeries<Sales, String>>[
        ColumnSeries<Sales, String>(
          dataSource: widget.data,
          xValueMapper: (Sales sales, _) =>
              sales.label, // Map category to x-axis
          yValueMapper: (Sales sales, _) =>
              sales.earning, // Map sales to y-axis
        )
      ],
    );
  }
}
