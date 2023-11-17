import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/orders/domain/repository/orders_repository.dart';

import 'package:khalsha/features/orders/domain/entities/order_model.dart';

class GetOrdersUseCase extends UseCase<List<OfferModel>, GetOrdersParams> {
  final OrdersRepository _ordersRepository;
  GetOrdersUseCase(this._ordersRepository);

  @override
  Future<Either<Failure, List<OfferModel>>> execute(params) async {
    final call = _ordersRepository.getOrders(
      params.type,
      params.pageIndex,
    );
    call.then((_) => params.loading(false));
    return call;
  }
}

class GetOrdersParams extends PaginationParams {
  final String type;
  GetOrdersParams({
    required super.loading,
    required this.type,
    required super.pageIndex,
    required super.loadingMoreData,
  });
}
