import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/providers/order.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/services/app.service.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/widgets/message_snack.dart';
// import 'package:rider/domain/order_item.model.dart';

class OrderDetail extends StatefulWidget {
  final OrderItem order;
  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    Location location = orderProvider.getItemLocation(widget.order);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 140.0))),
              child: Column(children: [
                const SizedBox(
                  height: 24,
                ),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.6,
                  child: Image.network(
                    "$baseURL${widget.order.product.image}",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        color: AppTheme.lightColor,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Order Info",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              // flex: 2,
                              child: Text(
                                widget.order.product.label,
                                style: const TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Amount: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppTheme.secondaryColor),
                                ),
                                Text(
                                  "${widget.order.quantity}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: AppTheme.lightColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        color: AppTheme.lightColor,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Delivery Info",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Placemark: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppTheme.secondaryColor),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                location.name,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Building Name: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppTheme.secondaryColor),
                            ),
                            Text(
                              location.block_name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Floor: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.secondaryColor),
                                  ),
                                  Text(
                                    location.floor_number,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.darkColor),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                                child: SizedBox(
                              width: 16.0,
                            )),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Room: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.secondaryColor),
                                  ),
                                  Text(
                                    location.room_number,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.darkColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: AppTheme.lightColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          color: AppTheme.lightColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            // Confirm order delivery
                            final Future response = AppService()
                                .confirmDelivery({
                              "order": widget.order.id,
                              "status": "Completed"
                            });

                            response.then((value) {
                              if (value['status']) {
                                // Update order
                                orderProvider.updateOrder(widget.order);

                                // // Show confirmation message
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     showMessage(true, value["message"]));

                                ScaffoldMessenger.of(context).showSnackBar(
                                    showMessage(true, "Delivery confirmed!"));

                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    showMessage(false, value["message"]));
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            shape: const StadiumBorder(),
                            backgroundColor: AppTheme.primaryColor,
                          ),
                          child: const Text(
                            "Confirm Delivery",
                            style: TextStyle(color: AppTheme.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
