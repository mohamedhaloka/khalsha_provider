import 'package:get/get.dart';
import 'package:khalsha/core/data/services/http_service.dart';
import 'package:khalsha/features/order_details/data/data_source/order_details_remote_data_source.dart';
import 'package:khalsha/features/orders/domain/entities/order_model.dart';

import '../../../../core/data/models/enums/service_types.dart';
import '../../../../core/domain/error/exceptions.dart';

abstract class MyBillsRemoteDataSource {
  Future<List<OrderModel>> getBills(String type, int pageIndex);
}

class MyBillsRemoteDataSourceImpl extends MyBillsRemoteDataSource {
  final HttpService _httpService;
  MyBillsRemoteDataSourceImpl(this._httpService);

  @override
  Future<List<OrderModel>> getBills(String type, int pageIndex) async {
    final response = await _httpService
        .get('${HttpService.userType}/billing?type=$type&page=$pageIndex');

    if (response.statusCode == 200) {
      final data = response.data['data']['billings']['data'];
      List<OrderModel> orders = <OrderModel>[];
      ServiceTypes? serviceTypes = ServiceTypes.values
          .firstWhereOrNull((element) => element.value == type);
      for (var item in data) {
        orders.add(serviceTypes!.getModel(item));
      }
      return orders;
    } else {
      throw ServerException(errorMessage: response.data.toString());
    }
  }
}
