import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khalsha/core/data/services/http_service.dart';
import 'package:khalsha/core/data/services/notification_service.dart';
import 'package:khalsha/core/data/source/local/user_local.dart';
import 'package:khalsha/core/presentation/error_view.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/presentation/themes/theme_manager.dart';
import 'package:khalsha/core/presentation/translation/app_translation.dart';
import 'package:khalsha/core/utils.dart' as utils;
import 'package:khalsha/features/auth/presentation/get/controllers/auth_controller.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/firebase_options.dart';
import 'package:khalsha/injection_container.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    ErrorWidget.builder = (FlutterErrorDetails details) => ErrorView(details);
    await _initServices();
    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    ever(
      authController.authStatus,
      (status) {
        if (status == AuthStatus.none) return;
        switch (status) {
          case AuthStatus.unAuthorized:
            _logOut();
            break;
          case AuthStatus.hasSettlement:
            _goToSettlementDetails();
            break;
          default:
            break;
        }
      },
    );
    super.initState();
  }

  void _logOut() {
    UserDataLocal.instance.remove();
    Get.offAllNamed(Routes.login);
    utils.showDialog(
      'يجب تسجيل الدخول للحساب مرة أخرى',
      onDoneTapped: Get.back,
      doneText: 'حسناً',
      showBackBtn: false,
    );
  }

  void _goToSettlementDetails() {
    Get.offAllNamed(
      Routes.settlementDetails,
      arguments: SettlementModel(id: authController.settlementId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Khalsha | خلصها',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.theme,
      getPages: AppPages.routes,
      translations: AppTranslation(),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: InkWell(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: child,
          ),
        );
      },
      initialRoute: _initialRoute,
      locale: _locale,
      fallbackLocale: const Locale('ar'),
    );
  }

  Locale get _locale => const Locale('ar');

  String get _initialRoute =>
      UserDataLocal.instance.isLoggedIn ? Routes.root : AppPages.initial;
}

Future<void> _initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.lazyPut<HttpService>(() => HttpService(Dio()));
  await GetStorage.init();
  await Future.wait([
    UserDataLocal.instance.init(),
    Get.putAsync<NotificationsService>(() => NotificationsService().init()),
    InjectionContainer.init(),
  ]);
}
