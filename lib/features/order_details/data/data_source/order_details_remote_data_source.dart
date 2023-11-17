import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/core/data/services/http_service.dart';
import 'package:khalsha/core/domain/error/exceptions.dart';
import 'package:khalsha/features/order_details/data/models/invoice_data.dart';
import 'package:khalsha/features/order_details/data/models/offer_input_item.dart';
import 'package:khalsha/features/orders/domain/entities/order_model.dart';

abstract class OrderDetailsRemoteDataSource {
  Future<OrderModel> getOrderDetails(String type, int id);

  Future<String> updateStep(
    String type,
    int statusId,
    String status,
    String note,
  );

  Future<void> rateOrder(
    double rate,
    String feedback,
    String orderId,
    String module,
  );

  Future<String> addOffer(
    String type,
    String orderId,
    List<OrderInputItemModel> inputs,
  );

  Future<String> createInvoice(String type, InvoiceData invoiceData);
}

class OrderDetailsRemoteDataSourceImpl extends OrderDetailsRemoteDataSource {
  final HttpService _httpService;
  OrderDetailsRemoteDataSourceImpl(this._httpService);

  @override
  Future<OrderModel> getOrderDetails(String type, int id) async {
    final response =
        await _httpService.get('${HttpService.userType}/$type/$id');

    if (response.statusCode == 200) {
      ServiceTypes? serviceType =
          ServiceTypes.values.firstWhereOrNull((e) => e.value == type);
      return serviceType!.getModel(response.data['result']);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<String> updateStep(
    String type,
    int statusId,
    String status,
    String note,
  ) async {
    final formData = dio.FormData.fromMap({
      'status': status,
      'note': note,
    });
    final response = await _httpService.post(
      '${HttpService.userType}/$type/action/step/$statusId',
      formData,
    );
    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }

  @override
  Future<void> rateOrder(
    double rate,
    String feedback,
    String orderId,
    String module,
  ) async {
    final formData = dio.FormData.fromMap({
      'rate': rate,
      'feedback': feedback,
      'module_id': orderId,
      'module': module,
    });
    final response = await _httpService.post(
      'auth/add/rate',
      formData,
    );
    if (response.statusCode != 200) {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }

  @override
  Future<String> addOffer(
    String type,
    String orderId,
    List<OrderInputItemModel> inputs,
  ) async {
    final data = <String, dynamic>{};
    for (var element in inputs) {
      data[element.field] = element.controller.text;
    }
    final formData = dio.FormData.fromMap(data);
    final response = await _httpService.post(
      '${HttpService.userType}/$type/add/offer/$orderId',
      formData,
    );
    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }

  @override
  Future<String> createInvoice(String type, InvoiceData invoiceData) async {
    bool isFromCustomsClearanceService = type == 'customsclearance';
    final formData = isFromCustomsClearanceService
        ? _prepareFormData(invoiceData)
        : dio.FormData.fromMap({});

    final response = await _httpService.post(
      '${HttpService.userType}/$type/invoice/${invoiceData.orderId}',
      formData,
    );

    if (response.statusCode == 200) {
      return isFromCustomsClearanceService
          ? response.data['message']
          : 'تم إنشاء الفاتورة بنجاح';
    } else {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }

  dio.FormData _prepareFormData(InvoiceData invoiceData) {
    final formData = dio.FormData.fromMap(invoiceData.toJson());

    _fillDataOfList(
      formData,
      dataList: invoiceData.service,
      key: 'service',
    );
    _fillDataOfList(
      formData,
      dataList: invoiceData.totals,
      key: 'totals',
    );

    return formData;
  }

  void _fillDataOfList(
    dio.FormData formData, {
    required List<String> dataList,
    required String key,
  }) {
    for (int i = 0; i < dataList.length; i++) {
      String item = dataList[i];
      if (item.isEmpty) continue;
      formData.fields.add(MapEntry('$key[$i]', item));
    }
  }
}

extension ServiceTypesToModel on ServiceTypes {
  OrderModel getModel(Map<String, dynamic> json) {
    switch (this) {
      case ServiceTypes.customsClearance:
        return CustomsClearanceOrder.fromJson(json);
      case ServiceTypes.landShipping:
        return LandShippingOrder.fromJson(json);
      case ServiceTypes.stores:
        return WareHouseOrder.fromJson(json);
      case ServiceTypes.marineShipping:
        return MarineShipmentOrder.fromJson(json);
      case ServiceTypes.airFreight:
        return AirFreightOrder.fromJson(json);
      case ServiceTypes.laboratoryAndStandards:
        return LaboratoryOrder.fromJson(json);
      default:
        return CustomsClearanceOrder.fromJson(json);
    }
  }
}
