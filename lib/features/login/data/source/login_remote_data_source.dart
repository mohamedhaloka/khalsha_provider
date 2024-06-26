import 'package:dio/dio.dart';

import '../../../../core/data/models/user_data_model.dart';
import '../../../../core/data/services/http_service.dart';
import '../../../../core/domain/error/exceptions.dart';
import '../models/social_type_enum.dart';

abstract class LoginRemoteDataSource {
  Future<UserData> login(String account, String password);

  Future<UserData> socialSignIn(SocialType type, String accessToken);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final HttpService _httpService;
  LoginRemoteDataSourceImpl(this._httpService);

  @override
  Future<UserData> login(String account, String password) async {
    final formData = FormData.fromMap({
      'account': account,
      'password': password,
    });

    final response = await _httpService.post('auth/login', formData);

    if (response.statusCode == 200) {
      return UserData.fromJson(response.data);
    } else {
      throw ServerException(errorMessage: response.data.toString());
    }
  }

  @override
  Future<UserData> socialSignIn(SocialType type, String accessToken) async {
    final formData = FormData.fromMap({
      'access_token': accessToken,
      'user_type': 'provider',
    });

    final response =
        await _httpService.post('auth/callback/${type.name}', formData);

    if (response.statusCode == 200) {
      return UserData.fromJson(response.data);
    } else {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }
}
