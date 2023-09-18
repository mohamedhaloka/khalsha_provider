import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/source/local/user_local.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/home/presentation/view.dart';
import 'package:khalsha/features/on_boarding/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/orders/presentation/view.dart';
import 'package:khalsha/features/profile/presentation/view.dart';
import 'package:khalsha/features/root/domain/use_cases/log_out_use_case.dart';
import 'package:khalsha/features/root/domain/use_cases/refresh_token_use_case.dart';

import '../../../../../core/data/models/item_model.dart';
import '../../../../../core/data/services/notification_service.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../home/presentation/get/controllers/controller.dart';
import '../../../../notifications/presentation/view.dart';
import '../../../../settlement/presentation/view.dart';
import '../../../domain/use_cases/update_fcm_token_use_case.dart';

class RootController extends GetxController {
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogOutUseCase _logiOutUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase;
  RootController(
    this._refreshTokenUseCase,
    this._logiOutUseCase,
    this._updateFCMTokenUseCase,
  );

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  PageController pageController = PageController(initialPage: 2);

  List<ItemModel> pages = <ItemModel>[], menu = <ItemModel>[];

  RxInt currentTab = 2.obs;

  String get pageTitle => pages[currentTab.value].text;

  RxString errorType = ''.obs;

  String get errorMessage {
    switch (errorType.value) {
      case 'need_verify_mobile':
        return 'يجب تفعيل جوالك عن طريق الكود المرسل له';
      case 'need_verify_email':
        return 'يجب تفعيل البريد الالكتروني عن طريق البيانات المرسلة للبريد الالكتروني الخاص بك';
    }
    return '';
  }

  final _notificationService = Get.find<NotificationsService>();
  final _homeController = Get.find<HomeController>();

  @override
  void onInit() {
    pages = [
      const ItemModel(
        id: 0,
        image: 'profile',
        text: 'حسابي',
        child: ProfileView(),
      ),
      const ItemModel(
        id: 1,
        image: 'orders',
        text: 'عروضي',
        child: OrdersView(),
      ),
      const ItemModel(
        id: 2,
        image: 'home',
        text: 'الرئيسية',
        child: HomeView(),
      ),
      const ItemModel(
        id: 3,
        image: 'notification',
        text: 'الإشعارات',
        child: NotificationsView(),
      ),
      const ItemModel(
        id: 4,
        image: 'settlement',
        text: 'التسوية',
        child: SettlementView(),
      ),
    ];

    menu = [
      const ItemModel(
        image: 'about',
        text: 'عن خلصها',
        route: Routes.onBoarding,
        arguments: IntroType.aboutApp,
      ),
      const ItemModel(
        image: 'blog',
        text: 'الإحصائيات',
        route: Routes.statistics,
      ),
      const ItemModel(
        image: 'resources',
        text: 'الطلبات الجديدة',
        route: Routes.newOrders,
      ),
      const ItemModel(
        image: 'common_questions',
        text: 'الأسئلة الشائعة',
        route: Routes.commonQuestions,
      ),
      const ItemModel(
        image: 'my-bills',
        text: 'الفواتير',
        route: Routes.myBills,
      ),
      const ItemModel(
        image: 'technical-support',
        text: 'الدعم للعملاء',
        route: Routes.contactUS,
      ),
      const ItemModel(
        id: 5,
        image: 'share',
        text: 'شارك خلصها',
        route: Routes.shareApp,
      ),
      const ItemModel(
        image: 'setting',
        text: 'إعدادات الحساب',
        route: Routes.accountSettings,
      ),
    ];

    _refreshToken();
    super.onInit();
  }

  void navigateToParticularPage(int? page) {
    if (errorType.isNotEmpty) return;
    pageController.animateToPage(
      page ?? 0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _refreshToken() async {
    final params = Params(loading: false.obs);
    final result = await _refreshTokenUseCase.execute(params);
    FlutterNativeSplash.remove();
    _homeController.videoController.play();

    result.fold(
      (failure) {
        final type = json.decode(failure.statusMessage ?? '')['type'];
        errorType(type);
      },
      (userData) {
        UserDataLocal.instance.save(userData.toJson());
        _updateFCMToken();
      },
    );
  }

  Future<void> logOut() async {
    final params = Params(loading: false.obs);
    await _logiOutUseCase.execute(params);
    UserDataLocal.instance.remove();
    Get.offAllNamed(Routes.onBoarding);
  }

  Future<void> _updateFCMToken() async {
    final fcmToken = await _notificationService.getFCMToken();
    final params = UpdateFCMTokenUseCaseParams(
      loading: false.obs,
      fcmToken: fcmToken,
    );
    await _updateFCMTokenUseCase.execute(params);
  }
}
