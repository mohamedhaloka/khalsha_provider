import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/presentation/extentions/response_extension.dart';
import 'package:khalsha/features/order_details/data/data_source/order_details_remote_data_source.dart';
import 'package:khalsha/features/order_details/data/models/invoice_data.dart';
import 'package:khalsha/features/order_details/domain/repository/order_details_repository.dart';

import '../../../../core/domain/error/exceptions.dart';
import '../../../orders/domain/entities/order_model.dart';
import '../models/offer_input_item.dart';

class OrderDetailsRepositoryImpl extends OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _orderDetailsRemoteDataSource;
  OrderDetailsRepositoryImpl(this._orderDetailsRemoteDataSource);

  @override
  Future<Either<Failure, OrderModel>> getOrderDetails(
    String type,
    int id,
  ) async {
    try {
      final result = await _orderDetailsRemoteDataSource.getOrderDetails(
        type,
        id,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }

  @override
  Future<Either<Failure, String>> updateStep(
    String type,
    int statusId,
    String status,
    String note,
  ) async {
    try {
      final result = await _orderDetailsRemoteDataSource.updateStep(
        type,
        statusId,
        status,
        note,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }

  @override
  Future<Either<Failure, Unit>> rateOrder(
      double rate, String feedback, String orderId, String module) async {
    try {
      await _orderDetailsRemoteDataSource.rateOrder(
        rate,
        feedback,
        orderId,
        module,
      );
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }

  @override
  Future<Either<Failure, String>> addOffer(
      String type, String orderId, List<OrderInputItemModel> inputs) async {
    try {
      final result =
          await _orderDetailsRemoteDataSource.addOffer(type, orderId, inputs);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }

  @override
  Future<Either<Failure, String>> createInvoice(
    String type,
    InvoiceData invoiceData,
  ) async {
    try {
      final result =
          await _orderDetailsRemoteDataSource.createInvoice(type, invoiceData);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }
}
