import 'package:flutter/material.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/screens/dashboard/pages/order_detail.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/utility/date_converter.dart';
import 'package:rider/utility/time_converter.dart';

class OrderCard extends StatelessWidget {
  final OrderItem order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> statusColor = {
      "Completed": AppTheme.primaryColor,
      "Cancelled": AppTheme.redColor,
      "Pending": Colors.yellow.shade700,
      "On Transit": AppTheme.darkColor
    };

    return InkWell(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => OrderDetail(order: order)),
            ),
          )),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: AppTheme.lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  alignment: Alignment.center,
                  child: Image.network(
                    "$baseURL${order.product.image}",
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.product.label,
                    style: const TextStyle(
                        color: AppTheme.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Text(order.product.description,
                  //     style: const TextStyle(
                  //         color: AppTheme.darkColor,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.bold)),

                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: statusColor[order.status]!,
                          ),
                          child: Text(
                            order.status,
                            style: const TextStyle(color: AppTheme.lightColor),
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Quantity:"),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "${order.quantity}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            convertDate(order.date),
                            style: const TextStyle(
                                color: AppTheme.secondaryColor, fontSize: 14),
                          ),
                          Text(
                            convertTime(order.time),
                            style: const TextStyle(
                                color: AppTheme.secondaryColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
