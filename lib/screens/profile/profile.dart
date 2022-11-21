import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/providers/order.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/screens/auth/login_screen.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/widgets/order_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthenticationProvider>().user;
    var orderProvider = Provider.of<OrderProvider>(context);

    var orders = orderProvider.dataCompleted();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,        
        actions: [
          InkWell(
            onTap: () => {
              AuthenticationProvider.instance.logout(),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => LoginScreen()),
                ),
              )
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: AppTheme.gradientColor,
                child: Icon(
                  Icons.logout_outlined,
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          )
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      CircleAvatar(
                        backgroundColor: AppTheme.whiteColor,
                        radius: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/user.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          user.firstName.isEmpty
                              ? "Anonymous"
                              : "${user.firstName} ${user.lastName}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          user.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.secondaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      user.firstName.isEmpty
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoute.profileEdit);
                              },
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Container()
                    ],
                  ),
                ),
              ),
            ),

            // Lower layer
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                   "Orders Completed",
                  style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // List view
            orders.isEmpty
                ? //check if customer has made any orders
                SliverToBoxAdapter(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: AppTheme.lightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              Text(
                                "No orders yet!",
                                style: TextStyle(
                                    color: AppTheme.darkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                            ],
                          ),
                        )),
                  )
                : //Show order list

                SliverList(
                    delegate: SliverChildBuilderDelegate(((
                      context,
                      index,
                    ) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OrderCard(
                          order: orders[index],
                        ),
                      );
                    }), childCount: orders.length),
                  ),
          ],
        ),
      ),
    );
  }
}
