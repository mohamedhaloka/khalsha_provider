import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/order_details/data/models/offer_input_item.dart';
import 'package:khalsha/features/order_details/domain/repository/order_details_repository.dart';

class AddOfferUseCase extends UseCase<String, AddOfferUseCaseParams> {
  final OrderDetailsRepository _orderDetailsRepository;
  AddOfferUseCase(this._orderDetailsRepository);

  @override
  Future<Either<Failure, String>> execute(AddOfferUseCaseParams params) {
    params.loading(true);
    final call = _orderDetailsRepository.addOffer(
      params.type,
      params.orderId,
      params.inputs,
    );
    call.then((_) => params.loading(false));
    return call;
  }
}

class AddOfferUseCaseParams extends Params {
  final String type, orderId;
  final List<OrderInputItemModel> inputs;
  AddOfferUseCaseParams({
    required super.loading,
    required this.type,
    required this.orderId,
    required this.inputs,
  });
}
