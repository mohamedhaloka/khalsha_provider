import 'package:get/get.dart';
import 'package:khalsha/features/account_settings/presentation/get/binding/binding.dart';
import 'package:khalsha/features/account_settings/presentation/view.dart';
import 'package:khalsha/features/add_phone_number/presentation/get/bindings/binding.dart';
import 'package:khalsha/features/add_phone_number/presentation/view.dart';
import 'package:khalsha/features/common_questions/presentation/get/binding/binding.dart';
import 'package:khalsha/features/common_questions/presentation/view.dart';
import 'package:khalsha/features/contact_us/presentation/get/binding/binding.dart';
import 'package:khalsha/features/contact_us/presentation/view.dart';
import 'package:khalsha/features/forget_password/presentation/get/binding/binding.dart';
import 'package:khalsha/features/forget_password/presentation/view.dart';
import 'package:khalsha/features/intro/presentation/get/binding/binding.dart';
import 'package:khalsha/features/intro/presentation/view.dart';
import 'package:khalsha/features/login/presentation/get/bindings/binding.dart';
import 'package:khalsha/features/login/presentation/view.dart';
import 'package:khalsha/features/new_orders/presentation/get/binding/binding.dart';
import 'package:khalsha/features/new_orders/presentation/view.dart';
import 'package:khalsha/features/notifications/presentation/get/binding/binding.dart';
import 'package:khalsha/features/notifications/presentation/view.dart';
import 'package:khalsha/features/on_boarding/presentation/get/bindings/binding.dart';
import 'package:khalsha/features/on_boarding/presentation/view.dart';
import 'package:khalsha/features/order_details/presentation/get/binding/binding.dart';
import 'package:khalsha/features/order_details/presentation/view.dart';
import 'package:khalsha/features/orders/presentation/get/binding/binding.dart';
import 'package:khalsha/features/orders/presentation/view.dart';
import 'package:khalsha/features/otp/presentation/get/binding/binding.dart';
import 'package:khalsha/features/otp/presentation/view.dart';
import 'package:khalsha/features/payment/presentation/bindings/payment_binding.dart';
import 'package:khalsha/features/payment/presentation/views/payment_view.dart';
import 'package:khalsha/features/register/presentation/get/bindings/binding.dart';
import 'package:khalsha/features/register/presentation/view.dart';
import 'package:khalsha/features/reset_password/presentation/get/binding/binding.dart';
import 'package:khalsha/features/reset_password/presentation/view.dart';
import 'package:khalsha/features/root/presentation/get/binding/binding.dart';
import 'package:khalsha/features/root/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/root/presentation/view.dart';
import 'package:khalsha/features/settlement_details/presentation/get/binding/binding.dart';
import 'package:khalsha/features/settlement_details/presentation/view.dart';
import 'package:khalsha/features/statistics/presentation/get/binding/binding.dart';
import 'package:khalsha/features/statistics/presentation/view.dart';

part 'app_pages.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.onBoarding;

  static final routes = [
    GetPage(
      name: _Paths.onBoarding,
      page: () => const OnBoardingView(),
      binding: OnBoardingBindings(),
    ),
    GetPage(
      name: _Paths.intro,
      page: () => const IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => const OTPView(),
      binding: OTPBinding(),
    ),
    GetPage(
      name: _Paths.root,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.commonQuestions,
      page: () => const CommonQuestionsView(),
      binding: CommonQuestionsBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.contactUS,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.orderDetails,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.settlementDetails,
      page: () => const SettlementDetailsView(),
      binding: SettlementDetailsBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.accountSettings,
      page: () => const AccountSettingsView(),
      binding: AccountSettingsBinding(),
    ),
    GetPage(
      name: _Paths.orders,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.newOrders,
      page: () => const NewOrdersView(),
      binding: NewOrdersBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.statistics,
      page: () => const StatisticsView(),
      binding: StatisticsBinding(),
      middlewares: [VerifyAccountMiddleware()],
    ),
    GetPage(
      name: _Paths.forgetPassword,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.addPhoneNumber,
      page: () => const AddPhoneNumberView(),
      binding: AddPhoneNumberBinding(),
    ),
  ];
}

class VerifyAccountMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    final rootController = Get.find<RootController>();
    if (rootController.needToVerifyAccount) {
      return null;
    }
    return page;
  }
}
