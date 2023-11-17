import 'package:dartz/dartz.dart';
import 'package:khalsha/core/data/repository_impl/base_repository_impl.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/order_details/data/data_source/order_details_remote_data_source.dart';
import 'package:khalsha/features/order_details/data/models/invoice_data.dart';
import 'package:khalsha/features/order_details/data/models/offer_input_item.dart';
import 'package:khalsha/features/order_details/domain/repository/order_details_repository.dart';
import 'package:khalsha/features/orders/domain/entities/order_model.dart';

class OrderDetailsRepositoryImpl extends BaseRepositoryImpl
    implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _orderDetailsRemoteDataSource;
  OrderDetailsRepositoryImpl(this._orderDetailsRemoteDataSource);

  @override
  Future<Either<Failure, OrderModel>> getOrderDetails(
    String type,
    int id,
  ) async {
    return request(() async {
      final result = await _orderDetailsRemoteDataSource.getOrderDetails(
        type,
        id,
      );
      return right(result);
    });
  }

  @override
  Future<Either<Failure, String>> updateStep(
    String type,
    int statusId,
    String status,
    String note,
  ) async {
    return request(() async {
      final result = await _orderDetailsRemoteDataSource.updateStep(
        type,
        statusId,
        status,
        note,
      );
      return right(result);
    });
  }

  @override
  Future<Either<Failure, Unit>> rateOrder(
      double rate, String feedback, String orderId, String module) async {
    return request(() async {
      await _orderDetailsRemoteDataSource.rateOrder(
        rate,
        feedback,
        orderId,
        module,
      );
      return right(unit);
    });
  }

  @override
  Future<Either<Failure, String>> addOffer(
      String type, String orderId, List<OrderInputItemModel> inputs) async {
    return request(() async {
      final result =
          await _orderDetailsRemoteDataSource.addOffer(type, orderId, inputs);
      return right(result);
    });
  }

  @override
  Future<Either<Failure, String>> createInvoice(
    String type,
    InvoiceData invoiceData,
  ) async {
    return request(() async {
      final result =
          await _orderDetailsRemoteDataSource.createInvoice(type, invoiceData);
      return right(result);
    });
  }
}
