import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/order_details/domain/repository/order_details_repository.dart';

import '../../data/models/invoice_data.dart';

class CreateInvoiceUseCase extends UseCase<String, CreateInvoiceUseCaseParams> {
  final OrderDetailsRepository _orderDetailsRepository;
  CreateInvoiceUseCase(this._orderDetailsRepository);

  @override
  Future<Either<Failure, String>> execute(CreateInvoiceUseCaseParams params) {
    params.loading(true);
    final call = _orderDetailsRepository.createInvoice(params.invoiceData);
    call.then((_) => params.loading(false));
    return call;
  }
}

class CreateInvoiceUseCaseParams extends Params {
  final InvoiceData invoiceData;
  CreateInvoiceUseCaseParams({
    required super.loading,
    required this.invoiceData,
  });
}
