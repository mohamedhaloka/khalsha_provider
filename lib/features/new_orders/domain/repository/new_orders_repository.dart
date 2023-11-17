import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';

import 'package:khalsha/features/new_orders/data/models/new_order_model.dart';

abstract class NewOrdersRepository {
  Future<Either<Failure, List<NewOrderModel>>> getNewOrders(String type);
}
