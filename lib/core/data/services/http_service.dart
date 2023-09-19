import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:path_provider/path_provider.dart';

import '../source/local/lang_locale.dart';
import '../source/local/user_local.dart';

class HttpService extends GetxService {
  HttpService(Dio dio) {
    _dio = dio;
    _dio.options.baseUrl = baseURL;
  }

  static const baseURL = 'https://dev.khlasha.com/api/';
  static const fileBaseURL = '';
  static const userType = 'provider';

  late Dio _dio;

  Future<dio.Response> post(String endPoint, dio.FormData data) async {
    log(baseURL + endPoint, name: 'URL');
    log(data.fields.toString(), name: 'BODY');
    log(data.fields.length.toString(), name: 'BODY');
    log(data.files.length.toString(), name: 'BODY');

    var response = await _dio.post(
      baseURL + endPoint,
      data: data,
      options: Options(headers: header),
    );

    _checkHasASettlement(response);
    return response;
  }

  Future<dio.Response> put(String endPoint, Map<String, dynamic> data) async {
    log(baseURL + endPoint, name: 'URL');
    log(data.toString(), name: 'BODY');
    log(data.length.toString(), name: 'BODY');

    var response = await _dio.put(
      baseURL + endPoint,
      data: data,
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        headers: header,
      ),
    );
    _checkHasASettlement(response);
    return response;
  }

  void _checkHasASettlement(dio.Response response) {
    if ((response.data as Map<String, dynamic>).containsKey('settlement')) {
      int settlementId = response.data['settlement'];
      Get.offAllNamed(
        Routes.settlementDetails,
        arguments: SettlementModel(id: settlementId),
      );
    }
  }

  Future<File> download(String url) async {
    log('DOWNLOAD URL $url');
    var tempDir = await getTemporaryDirectory();
    String fullPath = '${tempDir.path}/${url.split('/').last}';
    log('File name $fullPath');
    bool isExist = await File(fullPath).exists();

    if (isExist) {
      return File(fullPath);
    }
    var response = await _dio.get(
      fileBaseURL + url,
      options: dio.Options(
          responseType: dio.ResponseType.bytes, followRedirects: false),
    );
    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  }

  Future<dio.Response> get(endPoint) async {
    log('URL ${baseURL + endPoint}');
    var response = await _dio.get(
      baseURL + endPoint,
      options: Options(headers: header),
    );
    return response;
  }

  static Map<String, String> get header => {
        'Authorization': 'Bearer ${UserDataLocal.instance.token}',
        'Cookie':
            'XSRF-TOKEN=${UserDataLocal.instance.token}; khalasha_session=',
        'lang': Lang.instance.langCode,
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };
}
