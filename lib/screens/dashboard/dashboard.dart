import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/providers/order.provider.dart';
import 'package:rider/providers/rider.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/utility/greetings.utility.dart';
import 'package:rider/widgets/order_card.dart';
import 'package:rider/widgets/order_card_skeleton.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var greetings = greetingMessage();

    // Load user
    var user = context.watch<AuthenticationProvider>().user;
    var rider = context.watch<RiderProvider>().rider;

    var orders = Provider.of<OrderProvider>(context);

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          orders.refresh();
        });
      },
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 28,
          ),

          // Appbar
          Container(
            color: AppTheme.whiteColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () =>
                          {Navigator.pushNamed(context, AppRoute.profile)},
                      child: Image.asset(
                        "assets/images/user.png",
                        scale: 3.6,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              greetings,
                              style: const TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              rider.brand,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (() => {
                            // Navigator.pushNamed(context, AppRoute.location)
                          }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: const BoxDecoration(
                            color: AppTheme.lightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              CupertinoIcons.time,
                              color: AppTheme.primaryColor,
                              size: 16,
                            ),
                            Text(
                              // "History",
                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              softWrap: false,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: AppTheme.primaryColor,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Code later after presentations
                  // const NotificationIcon(),
                ],
              ),
            ),
          ),

          // Rider order list
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Available orders",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: const BoxDecoration(
                        color: AppTheme.lightColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: const Text(
                      "Pending",
                      style: TextStyle(color: AppTheme.secondaryColor),
                    ))
              ],
            ),
          ),

          orders.status == ServiceStatus.loadingSuccess
              ? orders.data().isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((
                        context,
                        index,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: OrderCard(
                            order: orders.data()[index],
                          ),
                        );
                      }),
                      itemCount: orders.data().length)
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "No order available yet",
                        style: TextStyle(
                            color: AppTheme.secondaryColor, fontSize: 18),
                      ),
                    )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((
                    context,
                    index,
                  ) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: OrderCardSkeleton(),
                    );
                  }),
                  itemCount: 6,
                ),
        ]),
      ),
    );
  }
}
