import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khalsha/core/data/models/item_model.dart';
import 'package:khalsha/core/data/models/user_data_model.dart';
import 'package:khalsha/core/data/services/notification_service.dart';
import 'package:khalsha/core/data/source/local/user_local.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/utils.dart';
import 'package:khalsha/features/auth/presentation/get/controllers/auth_controller.dart';
import 'package:khalsha/features/login/data/models/social_type_enum.dart';
import 'package:khalsha/features/login/domain/use_cases/login_use_case.dart';
import 'package:khalsha/features/login/domain/use_cases/social_login_use_case.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  final SocialLoginUseCase _socialLoginUseCase;

  LoginController(this._loginUseCase, this._socialLoginUseCase);

  List<ItemModel> socials = <ItemModel>[
    const ItemModel(id: 0, text: 'Google', image: 'google'),
    // const ItemModel(id: 1, text: 'Facebook', image: 'facebook'),
    if (GetPlatform.isIOS) ...[
      const ItemModel(id: 2, text: 'IOS', image: 'apple'),
    ]
  ];

  RxBool loading = false.obs, passSecure = true.obs;

  TextEditingController account = TextEditingController(),
      password = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final _notificationService = Get.find<NotificationsService>();
  final _authController = Get.find<AuthController>();

  @override
  void onInit() {
    _notificationService.deleteToken();
    _notificationService.unSubscribeToTopic(NotificationsService.topicName);
    super.onInit();
  }

  @override
  void onReady() {
    _authController.changeStatus(AuthStatus.none);
    super.onReady();
  }

  Future<void> login() async {
    if (_anyInputIsEmpty) {
      showAlertMessage('جميع الحقول مطلوبة');
      return;
    }
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    final params = LoginParams(
      loading: loading,
      password: password.text,
      account: account.text,
    );

    final result = await _loginUseCase.execute(params);
    result.fold(
      (Failure failure) {
        try {
          String errorMessage =
              json.decode(failure.statusMessage!)['error'].toString().trim();
          if (errorMessage == 'Unauthorized') {
            showAlertMessage('تأكد من البريد الإلكتروني و كلمة المرور');
          }
        } catch (_) {
          showAlertMessage(failure.statusMessage);
        }
      },
      (UserData userData) async {
        if (userData.user?.userType != UserType.provider.value) {
          downloadImporterExporterApp();
          return;
        }
        await UserDataLocal.instance.save(userData.toJson());
        Get.offAllNamed(Routes.root);
      },
    );
  }

  bool get _anyInputIsEmpty => account.text.isEmpty || password.text.isEmpty;

  Future<void> googleSignIn() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      log(googleSignInAuthentication!.accessToken.toString(),
          name: 'ACCESS TOKEN');
      log(googleSignInAuthentication.idToken.toString(), name: 'ID TOKEN');

      await _socialSignIn(
        socialType: SocialType.google,
        accessToken: googleSignInAuthentication.accessToken.toString(),
      );
    } catch (_) {}
  }

  Future<void> facebookSignIn() async {
    try {
      final LoginResult loginResult = await FacebookAuth.i.login(
        permissions: ['public_profile'],
      );

      log(loginResult.accessToken!.token, name: 'FACEBOOK ID TOKEN');

      await _socialSignIn(
        socialType: SocialType.facebook,
        accessToken: loginResult.accessToken!.token.toString(),
      );
    } catch (error) {
      log(error.toString(), name: 'FACEBOOK SIGN IN ERROR');
      // showAlertMessage('FACEBOOK SIGN IN ERROR ${error.toString()}');
    }
  }

  Future<void> appleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      await _socialSignIn(
        socialType: SocialType.apple,
        accessToken: credential.identityToken.toString(),
      );
    } catch (error) {
      log(error.toString(), name: 'APPLE SIGN IN ERROR');
      // showAlertMessage('APPLE SIGN IN ERROR ${error.toString()}');
    }
  }

  Future<void> _socialSignIn({
    required SocialType socialType,
    required String accessToken,
  }) async {
    final params = SocialLoginParams(
      loading: loading,
      type: socialType,
      accessToken: accessToken,
    );
    final result = await _socialLoginUseCase.execute(params);
    result.fold(
      (Failure failure) => showAlertMessage(failure.statusMessage),
      (UserData userData) {
        if (userData.user?.userType != UserType.provider.value) {
          downloadImporterExporterApp();
          return;
        }
        if ((userData.dataOrNull.mobile ?? '').isEmpty) {
          Get.toNamed(
            Routes.addPhoneNumber,
            arguments: userData.toJson(),
          );
          return;
        }
        UserDataLocal.instance.save(userData.toJson());
        Get.offAllNamed(Routes.root);
      },
    );
  }
}
