import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';

import '../entities/order_model.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OfferModel>>> getOrders(String type, int page);
}
