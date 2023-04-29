import 'package:dartz/dartz.dart';

import '../../../../core/domain/error/failures.dart';
import '../../../orders/domain/entities/order_model.dart';
import '../../data/models/offer_input_item.dart';

abstract class OrderDetailsRepository {
  Future<Either<Failure, OrderModel>> getOrderDetails(String type, int id);

  Future<Either<Failure, String>> updateStep(
    String type,
    int statusId,
    String status,
    String note,
  );

  Future<Either<Failure, Unit>> rateOrder(
    double rate,
    String feedback,
    String orderId,
    String module,
  );

  Future<Either<Failure, String>> addOffer(
    String type,
    String orderId,
    List<OrderInputItemModel> inputs,
  );
}
