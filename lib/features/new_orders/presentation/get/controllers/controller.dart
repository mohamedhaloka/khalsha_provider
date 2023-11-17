import 'package:get/get.dart';
import 'package:khalsha/features/new_orders/data/models/new_order_model.dart';
import 'package:khalsha/features/new_orders/domain/use_case/get_new_orders_use_case.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/core/utils.dart';
import 'package:khalsha/features/orders/domain/use_cases/get_orders_use_case.dart';

class NewOrdersController extends GetxController {
  final GetNewOrdersUseCase _getNewOrdersUseCase;
  NewOrdersController(this._getNewOrdersUseCase);

  RxInt selectedService = 0.obs;
  int currentPage = 1;
  List<NewOrderModel> orders = <NewOrderModel>[];

  RxBool loading = false.obs;

  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    _getOrders();
    super.onInit();
  }

  Future<void> _getOrders() async {
    orders.clear();
    final params = GetOrdersParams(
      loading: loading,
      type: ServiceTypes.values[selectedService.value].value,
      pageIndex: currentPage,
      loadingMoreData: false.obs,
    );
    final result = await _getNewOrdersUseCase.execute(params);
    result.fold(
      (failure) => showAlertMessage(failure.statusMessage),
      (data) => orders.addAll(data),
    );
  }

  Future<void> onRefresh() async {
    orders.clear();
    currentPage = 1;
    loading(true);
    await _getOrders();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    currentPage++;
    await _getOrders();
    refreshController.loadComplete();
  }
}
