part of '../../view.dart';

class OrderDetailsController extends GetxController {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final DeleteFileUseCase _deleteFileUseCase;
  final RateOrderUseCase _rateOrderUseCase;
  final AddOfferUseCase _addOfferUseCase;
  final CreateInvoiceUseCase _createInvoiceUseCase;
  OrderDetailsController(
    this._getOrderDetailsUseCase,
    this._updateOrderStatusUseCase,
    this._uploadImageUseCase,
    this._deleteFileUseCase,
    this._rateOrderUseCase,
    this._createInvoiceUseCase,
    this._addOfferUseCase,
  );

  int orderId = Get.arguments['orderId'];
  ServiceTypes serviceType = Get.arguments['serviceType'];
  bool isBill = Get.arguments['isBill'];

  RxInt currentTab = 0.obs;
  PageController pageViewController = PageController();

  RxBool loading = true.obs,
      createInvoiceLoading = false.obs,
      rateOrderLoading = false.obs,
      showInvoiceLoading = false.obs;

  late OrderModel orderModel;

  List<ItemModel> pages = [
    const ItemModel(
      id: 0,
      text: '',
      image: 'data',
      child: _OrderDataTab(),
    ),
    const ItemModel(
      id: 1,
      text: '',
      image: 'track',
      child: _StatusData(),
    ),
    const ItemModel(
      id: 2,
      text: '',
      image: 'bill',
      child: _BillDataTab(),
    ),
  ];

  TextEditingController ship = TextEditingController(),
      typeGoods = TextEditingController(),
      landingNumber = TextEditingController(),
      containerCount = TextEditingController(),
      weight = TextEditingController(),
      importListNumber = TextEditingController(),
      totalWithoutTax = TextEditingController(),
      totalTax = TextEditingController(),
      total = TextEditingController(),
      notes = TextEditingController();

  DateTime? importListDate;

  RxList<InvoiceItemModel> invoiceItems = <InvoiceItemModel>[
    InvoiceItemModel.newItem(),
  ].obs;

  final formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() {
    getOrderDetails();
    super.onInit();
  }

  void didFieldChanged(String fieldName, {required String value}) =>
      formKey.currentState?.fields[fieldName]!.didChange(value);

  void goToParticularPage(int index) => pageViewController.jumpToPage(index);

  Future<void> getOrderDetails() async {
    final params = GetOrderDetailsUseCaseParams(
      loading: loading,
      type: serviceType.value,
      orderId: orderId,
    );
    final result = await _getOrderDetailsUseCase.execute(params);
    result.fold(
      (_) => _,
      _onGetOrderDetailsSuccess,
    );
  }

  void _onGetOrderDetailsSuccess(OrderModel orderData) async {
    orderModel = orderData;
    currentTab(0);

    if (serviceType != ServiceTypes.customsClearance) {
      pages.removeWhere((element) => element.id == 1);
    }

    if (orderModel.invoice == null) {
      pages.removeWhere((element) => element.id == 2);
    }

    await Future.delayed(const Duration(milliseconds: 300));
    if (isBill) {
      int indexOfLaseTab =
          pages.indexWhere((element) => element.id == pages.last.id);
      goToParticularPage(indexOfLaseTab);
    }
  }

  Future<void> updateOrderStatus({
    required String comment,
    required String status,
    required int statusId,
  }) async {
    final params = UpdateOrderStatusUseCaseParams(
      loading: false.obs,
      type: ServiceTypes.customsClearance.value,
      statusId: statusId,
      status: status,
      comment: comment,
    );
    final result = await _updateOrderStatusUseCase.execute(params);
    result.fold(
      (l) => util.showAlertMessage(l.statusMessage),
      (r) => util.showAlertMessage(r),
    );
  }

  Future<void> uploadStepImages({
    required int statusId,
    required List<File> images,
  }) async {
    for (var image in images) {
      final params = UploadImageUseCaseParams(
        loading: false.obs,
        pageName: '${ServiceTypes.customsClearance.value}/step',
        path: 'customclearancestep${orderModel.id}',
        orderId: statusId.toString(),
        field: 'customclearancestep_file',
        filePath: image.path,
      );
      final result = await _uploadImageUseCase.execute(params);
      result.fold(
        (_) => _,
        (r) => util.showAlertMessage(r),
      );
    }
  }

  Future<void> deleteImage(int imageId) async {
    final params = DeleteFileUseCaseParams(
        loading: false.obs,
        pageName: '${ServiceTypes.customsClearance.value}/step',
        id: imageId);
    final result = await _deleteFileUseCase.execute(params);
    result.fold(
      (l) => util.showAlertMessage(l.statusMessage),
      (r) {
        util.showAlertMessage(r);
        getOrderDetails();
      },
    );
  }

  Future<void> rateOrder({
    required double rate,
    required String feedback,
  }) async {
    final params = RateOrderUseCaseParams(
      loading: rateOrderLoading,
      rate: rate,
      feedback: feedback,
      module: serviceType.value,
      orderId: orderId.toString(),
    );
    final result = await _rateOrderUseCase.execute(params);
    result.fold(
      (failure) => util.showAlertMessage(failure.statusMessage),
      (_) {
        util.showAlertMessage('تم تقييم الطلب بنجاح');
        Get.back();
        getOrderDetails();
      },
    );
  }

  Future<void> addOffer(List<OrderInputItemModel> inputs) async {
    final params = AddOfferUseCaseParams(
      loading: loading,
      type: serviceType.value,
      inputs: inputs,
      orderId: orderId.toString(),
    );
    final result = await _addOfferUseCase.execute(params);
    result.fold(
      (failure) => util.showAlertMessage(failure.statusMessage),
      (msg) {
        util.showAlertMessage(msg);
        Get.back();
        Get.back(result: true);
      },
    );
  }

  InvoiceData get _invoiceData => InvoiceData(
        orderId: orderId.toString(),
        totalPercents:
            invoiceItems.map((element) => element.totalPercents.text).toList(),
        totalTaxs:
            invoiceItems.map((element) => element.totalTaxs.text).toList(),
        totalWithoutTaxs: invoiceItems
            .map((element) => element.totalWithoutTaxs.text)
            .toList(),
        totals: invoiceItems.map((element) => element.totals.text).toList(),
        containerNumbers: invoiceItems
            .map((element) => element.containerNumbers.text)
            .toList(),
        service: invoiceItems.map((element) => element.service.text).toList(),
        total: total.text,
        totalTax: totalTax.text,
        totalWithoutTax: totalWithoutTax.text,
        importListNumber: importListNumber.text,
        weight: weight.text,
        containerCount: containerCount.text,
        typeGoods: typeGoods.text,
        ship: ship.text,
        note: notes.text,
        importListDate: importListDate?.formatDateTime(regularDateFormat) ?? '',
        ladingNumber: landingNumber.text,
      );

  Future<void> createInvoice() async {
    if (serviceType == ServiceTypes.customsClearance) {
      formKey.currentState?.save();

      if (!formKey.currentState!.validate()) return;
    }

    final params = CreateInvoiceUseCaseParams(
      loading: createInvoiceLoading,
      invoiceData: _invoiceData,
      type: serviceType.value,
    );
    final result = await _createInvoiceUseCase.execute(params);
    result.fold(
      (failure) => util.showAlertMessage(failure.statusMessage),
      (msg) {
        util.showAlertMessage(msg);
        getOrderDetails();
      },
    );
  }

  Future<void> showInvoice(String url) async {
    showInvoiceLoading(true);
    var tempDir = await getTemporaryDirectory();
    String fullPath = '${tempDir.path}/invoice_${url.split('/').last}.pdf';

    final response = await http.get(
      Uri.parse(url),
      headers: HttpService.header,
    );
    print(response.body);
    if (response.statusCode != 200) return;
    File pdfFile = await File(fullPath).writeAsBytes(response.bodyBytes);
    Get.to(() => InvoiceDetailsView(path: pdfFile.path));
    showInvoiceLoading(false);
  }
}
