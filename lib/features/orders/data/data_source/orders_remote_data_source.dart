import 'package:get/get.dart';
import 'package:khalsha/core/data/services/http_service.dart';

import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/core/domain/error/exceptions.dart';
import 'package:khalsha/features/orders/domain/entities/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OfferModel>> getOrders(String type, int page);
}

class OrdersRemoteDataSourceImpl extends OrdersRemoteDataSource {
  final HttpService _httpService;
  OrdersRemoteDataSourceImpl(this._httpService);

  @override
  Future<List<OfferModel>> getOrders(String type, int page) async {
    final response = await _httpService
        .get('${HttpService.userType}/offers?type=$type&page=$page');

    if (response.statusCode == 200) {
      final data = response.data['data']['offers']['data'];
      List<OfferModel> orders = <OfferModel>[];
      ServiceTypes? serviceTypes = ServiceTypes.values
          .firstWhereOrNull((element) => element.value == type);

      for (var item in data) {
        orders.add(serviceTypes!.toOffer(item));
      }
      return orders;
    } else {
      throw ServerException(errorMessage: response.data.toString());
    }
  }
}

extension ServiceTypesToModel on ServiceTypes {
  OfferModel toOffer(Map<String, dynamic> json) {
    switch (this) {
      case ServiceTypes.customsClearance:
        return CustomsClearanceOffer.fromJson(json);
      case ServiceTypes.landShipping:
        return LandShippingOffer.fromJson(json);
      case ServiceTypes.stores:
        return WareHouseOffer.fromJson(json);
      case ServiceTypes.marineShipping:
        return MarineShipmentOffer.fromJson(json);
      case ServiceTypes.airFreight:
        return AirFreightOffer.fromJson(json);
      case ServiceTypes.laboratoryAndStandards:
        return LaboratoryOffer.fromJson(json);
    }
  }
}
