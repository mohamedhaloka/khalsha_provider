import 'dart:convert';

import 'package:dio/dio.dart';

extension ResponseErrorMessage on Response<dynamic>? {
  String getErrorMessage() {
    if (this == null) return '';
    final data = this!.data;

    if (data is Map<String, dynamic>) {
      if (data.containsKey('settlement_id')) {
        int settlementId = data['settlement_id'];
        return json.encode({'settlement_id': settlementId});
      } else if (data.containsKey('message')) {
        return data['message'];
      }
    }

    return json.encode(data);
  }
}
