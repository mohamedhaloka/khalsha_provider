part of 'app_routes.dart';

abstract class Routes {
  Routes._();
  static const onBoarding = _Paths.onBoarding;
  static const intro = _Paths.intro;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const otp = _Paths.otp;
  static const root = _Paths.root;
  static const notifications = _Paths.notifications;
  static const commonQuestions = _Paths.commonQuestions;
  static const payment = _Paths.payment;
  static const contactUS = _Paths.contactUS;
  static const orderDetails = _Paths.orderDetails;
  static const settlementDetails = _Paths.settlementDetails;
  static const accountSettings = _Paths.accountSettings;
  static const orders = _Paths.orders;
  static const newOrders = _Paths.newOrders;
  static const statistics = _Paths.statistics;
  static const forgetPassword = _Paths.forgetPassword;
  static const resetPassword = _Paths.resetPassword;
  static const map = _Paths.map;
  static const addPhoneNumber = _Paths.addPhoneNumber;
}

abstract class _Paths {
  static const onBoarding = '/on_boarding';
  static const intro = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const root = '/root';
  static const notifications = '/notifications';
  static const commonQuestions = '/common_questions';
  static const payment = '/payment';
  static const contactUS = '/contact_us';
  static const orderDetails = '/order_details';
  static const settlementDetails = '/settlement_details';
  static const accountSettings = '/account_settings';
  static const orders = '/orders';
  static const newOrders = '/new_orders';
  static const statistics = '/statistics';
  static const forgetPassword = '/forget_password';
  static const resetPassword = '/reset_password';
  static const map = '/map';
  static const addPhoneNumber = '/add_phone_number';
}
