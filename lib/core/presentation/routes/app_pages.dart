part of 'app_routes.dart';

abstract class Routes {
  Routes._();
  static const onBoarding = _Paths.onBoarding;
  static const intro = _Paths.intro;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const otp = _Paths.otp;
  static const root = _Paths.root;
  static const commonQuestions = _Paths.commonQuestions;
  static const payment = _Paths.payment;
  static const myBills = _Paths.myBills;
  static const shareApp = _Paths.shareApp;
  static const sources = _Paths.sources;
  static const contactUS = _Paths.contactUS;
  static const blog = _Paths.blog;
  static const postDetails = _Paths.postDetails;
  static const orderDetails = _Paths.orderDetails;
  static const settlementDetails = _Paths.settlementDetails;
  static const billDetails = _Paths.billDetails;
  static const accountSettings = _Paths.accountSettings;
  static const howToUse = _Paths.howToUse;
  static const orders = _Paths.orders;
  static const newOrders = _Paths.newOrders;
  static const statistics = _Paths.statistics;
  static const forgetPassword = _Paths.forgetPassword;
  static const resetPassword = _Paths.resetPassword;
  static const map = _Paths.map;
  static const chooseShippingService = _Paths.chooseShippingService;
}

abstract class _Paths {
  static const onBoarding = '/on_boarding';
  static const intro = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const root = '/root';
  static const commonQuestions = '/common_questions';
  static const payment = '/payment';
  static const myBills = '/my_bills';
  static const shareApp = '/share_app';
  static const sources = '/sources';
  static const contactUS = '/contact_us';
  static const blog = '/blog';
  static const postDetails = '/post_details';
  static const orderDetails = '/order_details';
  static const settlementDetails = '/settlement_details';
  static const billDetails = '/bill_details';
  static const accountSettings = '/account_settings';
  static const howToUse = '/how_to_use';
  static const orders = '/orders';
  static const newOrders = '/new_orders';
  static const statistics = '/statistics';
  static const forgetPassword = '/forget_password';
  static const resetPassword = '/reset_password';
  static const map = '/map';
  static const chooseShippingService = '/choose_shipping_service';
}
