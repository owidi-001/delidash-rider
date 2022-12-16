import 'package:flutter/foundation.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/services/app.service.dart';

class OrderProvider with ChangeNotifier {
  List<RiderOrder> riderOrders = [];
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
      if (order.item.status == "Completed") {
        _ordersCompleted.add(order.item);
      } else {
        _orders.add(order.item);
      }
      riderOrders.add(order);
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

  // Remove order from orders list
  // Add order to completed
  void updateOrder(OrderItem order) async {
    if (_orders.contains(order)) {
      // Remove
      _orders.remove(order);
      // Add
      _ordersCompleted.add(order);
    }
    notifyListeners();
  }

  void refresh() async {
    await _initOrders();
  }

  // get item order delivery location
  Location getItemLocation(OrderItem item) {
    Location location = Location.empty();

    for (var order in riderOrders) {
      if (order.id == item.cart) {
        location = order.location;
        break;
      }
    }

    return location;
  }
}
