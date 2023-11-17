import 'package:dartz/dartz.dart';
import 'package:khalsha/core/data/repository_impl/base_repository_impl.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/new_orders/data/data_source/new_orders_remote_data_source.dart';
import 'package:khalsha/features/new_orders/data/models/new_order_model.dart';
import 'package:khalsha/features/new_orders/domain/repository/new_orders_repository.dart';

class NewOrdersRepositoryImpl extends BaseRepositoryImpl
    implements NewOrdersRepository {
  final NewOrdersRemoteDataSource _newOrdersRemoteDataSource;
  NewOrdersRepositoryImpl(this._newOrdersRemoteDataSource);

  @override
  Future<Either<Failure, List<NewOrderModel>>> getNewOrders(String type) async {
    return request(() async {
      final result = await _newOrdersRemoteDataSource.getNewOrders(type);
      return right(result);
    });
  }
}
