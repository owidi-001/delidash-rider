// API URL
// const String baseURL = "http://owidi.pythonanywhere.com";
const String baseURL = "http://192.168.0.102:8000";

// Routes for app
class AppRoute {
  static const String splash = "/";

  // auth routes
  static const String welcome = "/welcome";
  static const String register = "/register";
  static const String login = "/login";

  // Dashboard,list,detail routes
  static const String home = "/home";
  static const String dashboard = "/dashboard";
  static const String orderDetail = "/order_detail";

  // profile
  static const String profile = "/profile";
  static const String profileEdit = "/profileEdit";
}

class ApiUrl {
  // user auth
  static const String login = "$baseURL/auth/login/";
  static const String register = "$baseURL/auth/register/";
  static const String profileUpdate = "$baseURL/auth/profile/";
  static const String forgotPassword = "$baseURL/forgot-password";

  // orders
  static const String riders = "$baseURL/riders/";
  static const String orders = "$baseURL/riders/orders";

  // Orders status update
  static const String ordersEdit = "$baseURL/orders/";

}
