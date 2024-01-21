import 'package:amazon_clone/features/admin/model/sales_model.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();
  int? totalEarnings;
  List<Sales>? sales;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var data = await _adminServices.fetchEarnings(context);
    totalEarnings = data['totalEarnings'];
    sales = data['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarnings == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Text(
                '\$$totalEarnings',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          );
  }
}
