import 'package:flutter/foundation.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/services/app.service.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> _ordersCompleted = [];

  ServiceStatus status = ServiceStatus.initial;

  OrderProvider() {
    status = ServiceStatus.initial;
    _initOrders();
  }

  List<OrderItem> data() => _orders;
  List<OrderItem> dataCompleted() => _ordersCompleted;


  void setOrders(List<OrderItem> orders) {
    _orders = orders;
    notifyListeners();
  }

  // Gets orders or error from the API
  Future<void> _initOrders() async {
    // load orders
    final res = await AppService().fetchOrderItems();

    // _orders = res;

    for (var order in res) {
      if (order.status == "Completed") {
        _ordersCompleted.add(order);
      } else {
        _orders.add(order);
      }
    }
    status = ServiceStatus.loadingSuccess;

    notifyListeners();
  }

  // Add order to orders list
  void addOrder(OrderItem order) async {
    var orders = data();

    if (!orders.contains(order)) {
      orders.add(order);
    }
    notifyListeners();
  }
}
