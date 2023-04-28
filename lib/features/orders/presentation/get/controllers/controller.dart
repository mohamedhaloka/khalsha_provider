import 'package:get/get.dart';
import 'package:khalsha/features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/data/models/enums/service_types.dart';
import '../../../../../core/utils.dart';
import '../../../domain/entities/order_model.dart';

class OrdersController extends GetxController {
  final GetOrdersUseCase _getOrdersUseCase;
  OrdersController(
    this._getOrdersUseCase,
  );

  final ServiceTypes? serviceType = Get.arguments;

  RxInt selectedService = 0.obs;
  int currentPage = 1;

  RxList<OfferModel> orders = <OfferModel>[].obs;

  RxBool loading = true.obs;

  RefreshController refreshController = RefreshController();
  @override
  void onInit() {
    if (serviceType != null) {
      selectedService(serviceType!.index);
    }
    _getOrders();
    super.onInit();
  }

  Future<void> _getOrders() async {
    final params = GetOrdersParams(
      loading: loading,
      type: ServiceTypes.values[selectedService.value].value,
      pageIndex: currentPage,
      loadingMoreData: false.obs,
    );
    final result = await _getOrdersUseCase.execute(params);
    result.fold(
      (failure) {
        showAlertMessage(failure.statusMessage);
        currentPage = currentPage - 1;
      },
      (data) {
        if (data.isEmpty) {
          currentPage = currentPage - 1;
          return;
        }
        orders.addAll(data);
      },
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
