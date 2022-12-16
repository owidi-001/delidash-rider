import 'package:flutter/material.dart';
import 'package:rider/theme/app_theme.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context);

    return SizedBox(
      width: kToolbarHeight,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          const Icon(Icons.notifications),
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              width: 16,
              height: 16,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor,
              ),
              child: const Center(
                child: Text(
                  // "${cartProvider.items.length}",
                  "2",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
