part of 'order_model.dart';

class MarineShipmentOrder extends OrderModel {
  MarineShipmentOrder({
    required super.id,
    required super.title,
    required super.userId,
    required super.offers,
    required super.invoice,
    required super.offersNum,
    required super.offer,
    required super.user,
    required super.status,
    required super.certificates,
    required super.certificate,
    super.feedback,
    super.invoiceUrl,
    required this.shipmentType,
    required this.fromShipmentLocation,
    this.fromShipmentOtherLocation,
    required this.fromCountryId,
    required this.fromCity,
    required this.fromCityLat,
    required this.fromCityLng,
    required this.toShipmentLocation,
    this.toShipmentOtherLocation,
    required this.toCountryId,
    required this.toCity,
    required this.toCityLat,
    required this.toCityLng,
    required this.customsClearance,
    required this.total,
    required this.containers,
    required this.content,
    required this.shipmentSizes,
    required this.fromCountry,
    required this.goods,
    required this.insurance,
    required this.shipmentReady,
    required this.currencyId,
    required this.toCountry,
    required this.currency,
  });

  String shipmentType;
  String fromShipmentLocation;
  String? fromShipmentOtherLocation;
  int fromCountryId;
  String fromCity;
  String fromCityLat;
  String fromCityLng;
  String toShipmentLocation;
  String? toShipmentOtherLocation;
  int toCountryId;
  String toCity;
  String toCityLat;
  String toCityLng;
  String total;
  int currencyId;
  String shipmentReady;
  String content;
  String shipmentSizes;
  String insurance;
  String customsClearance;
  DataModel fromCountry;
  DataModel toCountry;
  List<MarineContainer> containers;
  List<MarineGoods> goods;
  DataModel? currency;

  int get shipmentTypeId {
    if (shipmentType == 'import') {
      return 0;
    } else {
      return 1;
    }
  }

  int get shipmentSizesId {
    if (shipmentSizes == 'container') {
      return 0;
    } else {
      return 1;
    }
  }

  factory MarineShipmentOrder.fromJson(Map<String, dynamic> json) =>
      MarineShipmentOrder(
        id: json['id'],
        shipmentType: json['shipment_type'],
        fromShipmentLocation: json['fromshipment_location'],
        fromShipmentOtherLocation: json['fromshipment_other_location'],
        fromCountryId: json['fromcountry_id'],
        fromCity: json['fromcity'] ?? '',
        fromCityLat: json['fromcity_lat'] ?? '',
        fromCityLng: json['fromcity_lng'] ?? '',
        toShipmentLocation: json['toshipment_location'] ?? '',
        toShipmentOtherLocation: json['toshipment_other_location'] ?? '',
        toCountryId: json['tocountry_id'] ?? 0,
        toCity: json['tocity'] ?? '',
        toCityLat: json['tocity_lat'] ?? '',
        toCityLng: json['tocity_lng'] ?? '',
        total: json['total'] ?? '',
        currencyId: json['currency_id'],
        shipmentReady: json['shipment_ready'],
        content: json['content'],
        shipmentSizes: json['shipment_sizes'],
        insurance: json['insurance'],
        customsClearance: json['customs_clearance'],
        certificate: json['certificate'] ?? 'no',
        title: json['title'],
        userId: json['user_id'],
        status: json['status'],
        invoiceUrl: json['invoice_url'],
        user: User.fromJson(json['user'] ?? {}),
        feedback: json['feedback'] == null
            ? null
            : FeedbackObj.fromJson(json['feedback']),
        certificates: List<DataModel>.from(
            (json['get_certificates'] ?? []).map((x) => DataModel.fromJson(x))),
        offers: List<MarineShipmentOffer>.from(
            (json['offers'] ?? []).map((x) => MarineShipmentOffer.fromJson(x))),
        invoice: json['invoice'] is List
            ? null
            : json['invoice'] == null
                ? null
                : MarineShipmentInvoice.fromJson(json['invoice']),
        offersNum: List<MarineShipmentOffer>.from(
          (json['offers'] ?? []).map((x) => MarineShipmentOffer.fromJson(x)),
        ).length,
        offer: json['offer'] == null
            ? null
            : MarineShipmentOffer.fromJson(json['offer']),
        containers: List<MarineContainer>.from(
            (json['containers'] ?? []).map((x) => MarineContainer.fromJson(x))),
        fromCountry: DataModel.fromJson(json['fromcountry'] ?? {}),
        goods: List<MarineGoods>.from(
            (json['goods'] ?? []).map((x) => MarineGoods.fromJson(x))),
        toCountry: DataModel.fromJson(json['tocountry'] ?? {}),
        currency: DataModel.fromJson(json['currency'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'user_id': userId,
        'invoice_url': invoiceUrl,
        'certificates': certificates,
        'status': status,
        'user': user.toJson(),
        'shipment_type': shipmentType,
        'fromshipment_location': fromShipmentLocation,
        'fromshipment_other_location': fromShipmentOtherLocation,
        'fromcountry_id': fromCountryId,
        'fromcity': fromCity,
        'fromcity_lat': fromCityLat,
        'fromcity_lng': fromCityLng,
        'toshipment_location': toShipmentLocation,
        'toshipment_other_location': toShipmentOtherLocation,
        'tocountry_id': toCountryId,
        'tocity': toCity,
        'tocity_lat': toCityLat,
        'tocity_lng': toCityLng,
        'total': total,
        'currency_id': currencyId,
        'shipment_ready': shipmentReady,
        'content': content,
        'shipment_sizes': shipmentSizes,
        'insurance': insurance,
        'customs_clearance': customsClearance,
        'feedback': feedback,
        'fromcountry': fromCountry.toJson(),
        'tocountry': toCountry.toJson(),
        'currency': currency?.toJson(),
        'containers': List<dynamic>.from(containers.map((x) => x.toJson())),
        'goods': List<dynamic>.from(goods.map((x) => x)),
        'get_certificates':
            List<dynamic>.from(certificates.map((x) => x.toJson())),
        'offers': List<dynamic>.from(offers.map((x) => x)),
        'invoice': '',
      };

  @override
  List<OrderSectionItemModel> get data => [
        OrderSectionItemModel(
          title: 'معلومات الطلب',
          data: [
            OrderDetailsItemModel(
              title: 'عنوان الطلب',
              description: title,
            ),
            OrderDetailsItemModel(
              title: 'نوع الشحنة',
              description: shipmentType,
            ),
            OrderDetailsItemModel(
              title: 'مكان الشحن',
              description: fromShipmentLocation,
            ),
            if (fromShipmentLocation == 'other') ...[
              OrderDetailsItemModel(
                title: 'مكان مخصص للشحن',
                description: fromShipmentOtherLocation,
              ),
            ],
            OrderDetailsItemModel(
              title: 'من الدولة',
              description: fromCountry.name,
            ),
            OrderDetailsItemModel(
              title: 'من العنوان',
              description: fromCity,
              value: '$fromCityLat,$fromCityLng',
              type: OrderDetailsTypes.mapDirection,
            ),
            OrderDetailsItemModel(
              title: 'مكان الشحنة',
              description: '$fromCityLat,$fromCityLng',
              value: '$fromCityLat,$fromCityLng',
              type: OrderDetailsTypes.mapDirection,
            ),
            OrderDetailsItemModel(
              title: 'الي مكان الشحنه',
              description: toShipmentLocation,
            ),
            if (toShipmentLocation == 'other') ...[
              OrderDetailsItemModel(
                title: 'مكان مخصص لتوصيل الشحن',
                description: toShipmentOtherLocation,
              ),
            ],
            OrderDetailsItemModel(
              title: 'الى الدولة',
              description: toCountry.name,
            ),
            OrderDetailsItemModel(
              title: 'الى العنوان',
              description: toCity,
              value: '$toCityLat,$toCityLng',
              type: OrderDetailsTypes.mapDirection,
            ),
            OrderDetailsItemModel(
              title: 'الى مكان الشحنة',
              description: '$toCityLat,$toCityLng',
              value: '$toCityLat,$toCityLng',
              type: OrderDetailsTypes.mapDirection,
            ),
            OrderDetailsItemModel(
              title: 'استخراج الشهادات المطلوبة لهذه الشحنة ؟',
              description: certificate,
            ),
            OrderDetailsItemModel(
              title: 'هل تريد خدمة التأمين ؟',
              description: insurance,
            ),
            OrderDetailsItemModel(
              title: 'هل تريد خدمة التخليص الجمركي ؟',
              description: customsClearance,
            ),
            OrderDetailsItemModel(
              title: 'قيمة البضاعة',
              description: '$total ${currency!.name}',
            ),
            OrderDetailsItemModel(
              title: 'ملاحظات',
              description: content,
            ),
          ],
        ),
        if (shipmentSizes == 'container') ...[
          OrderSectionItemModel(
            title: 'الحاوية',
            data: [
              for (var container in containers) ...[
                OrderDetailsItemModel(
                  title: 'نوع الحاوية',
                  description: container.containerType,
                ),
                OrderDetailsItemModel(
                  title: 'عدد الحاويات',
                  description: container.containerCount.toString(),
                ),
                OrderDetailsItemModel(
                  title: 'صورة الشحنة',
                  description: container.image,
                  type: OrderDetailsTypes.file,
                ),
                OrderDetailsItemModel(
                  title: 'تفاصيل الشحنة',
                  description: container.content,
                ),
              ]
            ],
          ),
        ] else ...[
          OrderSectionItemModel(
            title: 'البضائع المجمعة',
            data: [
              for (var item in goods) ...[
                if (item.unitType == 'pallet') ...[
                  OrderDetailsItemModel(
                    title: 'الطول',
                    description: item.length,
                  ),
                  OrderDetailsItemModel(
                    title: 'العرض',
                    description: item.width,
                  ),
                  OrderDetailsItemModel(
                    title: 'الارتفاع',
                    description: item.height,
                  ),
                  OrderDetailsItemModel(
                    title: 'سم',
                    description: item.cm,
                  ),
                  OrderDetailsItemModel(
                    title: 'الوزن لكل وحده',
                    description: item.weightPerUnit,
                  ),
                  OrderDetailsItemModel(
                    title: 'الكمية',
                    description: item.quantity,
                  ),
                  OrderDetailsItemModel(
                    title: 'صورة الشحنة',
                    description: item.image,
                    type: OrderDetailsTypes.file,
                  ),
                ] else ...[
                  OrderDetailsItemModel(
                    title: 'الحجم الكلي',
                    description: item.overallSize,
                  ),
                  OrderDetailsItemModel(
                    title: 'الوزن الكلي',
                    description: item.totalWeight,
                  ),
                  OrderDetailsItemModel(
                    title: 'الكمية',
                    description: item.quantity,
                  ),
                ]
              ]
            ],
          ),
        ],
        if (certificates.isNotEmpty)
          OrderSectionItemModel(
            title: 'الشهادات',
            data: [
              for (var item in certificates) ...[
                OrderDetailsItemModel(title: item.name),
              ]
            ],
          ),
        OrderSectionItemModel(
          title: 'التواصل',
          data: [
            OrderDetailsItemModel(title: 'صاحب الطلب', description: user.name),
            OrderDetailsItemModel(title: 'الجوال', description: user.mobile),
            OrderDetailsItemModel(
                title: 'البريد الإلكتروني', description: user.email),
          ],
        ),
      ];

  @override
  List<OrderInputItemModel> get offerInputs => <OrderInputItemModel>[
        OrderInputItemModel(
          textInputType: TextInputType.number,
          field: 'shipping_fee',
          title: 'رسوم الشحن',
          controller: TextEditingController(),
        ),
        OrderInputItemModel(
          textInputType: TextInputType.number,
          field: 'certificates',
          controller: TextEditingController(),
        ),
        OrderInputItemModel(
          textInputType: TextInputType.number,
          field: 'customs_clearance',
          controller: TextEditingController(),
        ),
        OrderInputItemModel(
          textInputType: TextInputType.number,
          field: 'total',
          controller: TextEditingController(),
        ),
        OrderInputItemModel(
          textInputType: TextInputType.text,
          field: 'note',
          isRequired: false,
          controller: TextEditingController(),
        ),
      ];
}

class MarineShipmentInvoice extends Invoice {
  MarineShipmentInvoice({
    required this.certificates,
    required this.customsClearance,
    required this.shippingFee,
    super.user,
    super.total,
    super.id,
    super.updatedAt,
    super.createdAt,
    super.status,
    super.note,
    super.deletedAt,
    super.userId,
  });

  final String shippingFee;
  final String customsClearance;
  final String certificates;

  factory MarineShipmentInvoice.fromJson(Map<String, dynamic> json) =>
      MarineShipmentInvoice(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        total: json['total'] ?? '0',
        shippingFee: json['shipping_fee'] ?? '0',
        customsClearance: json['customs_clearance'] ?? '0',
        certificates: json['certificates'] ?? '0',
        note: json['note'] ?? '',
        status: json['status'] ?? '',
        deletedAt: json['deleted_at'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        user: User.fromJson(json['user'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'total': total,
        'note': note,
        'status': status,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };

  @override
  List<ItemModel> get items => <ItemModel>[
        ItemModel(
          text: 'رسوم الشحن',
          description: shippingFee,
        ),
        ItemModel(
          text: 'رسوم الخدمات',
          description: certificates,
        ),
        ItemModel(
          text: 'الضريبة المضافة',
          description: customsClearance,
        ),
        ItemModel(
          text: 'الإجمالي',
          description: '$total ${'riyal_saudi'.tr}',
        ),
        ItemModel(
          text: 'ملاحظات',
          description: note,
        )
      ];
}

class MarineShipmentOffer extends OfferModel {
  MarineShipmentOffer({
    super.id,
    super.userId,
    super.status,
    super.note,
    super.acceptedAt,
    super.rejectedAt,
    super.createdAt,
    super.updatedAt,
    super.user,
    super.total,
    super.orderDetails,
    required this.customsClearance,
    required this.certificates,
    required this.shippingFee,
  });

  final String shippingFee;
  final String customsClearance;
  final String certificates;

  factory MarineShipmentOffer.fromJson(Map<String, dynamic> json) =>
      MarineShipmentOffer(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        status: json['status'] ?? '',
        note: json['note'] ?? '',
        total: json['total'] ?? '',
        shippingFee: json['shipping_fee'] ?? '',
        certificates: json['certificates'] ?? '',
        customsClearance: json['customs_clearance'] ?? '',
        orderDetails: OrderDetailsModel.fromJson(json['seashipping']),
        acceptedAt:
            DateTime.parse(json['accepted_at'] ?? DateTime.now().toString()),
        rejectedAt: json['rejected_at'],
        createdAt:
            DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
        user: User.fromJson(json['user'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'note': note,
        'customs_clearance': customsClearance,
        'shipping_fee': shippingFee,
        'certificates': certificates,
        'accepted_at': acceptedAt?.toIso8601String(),
        'rejected_at': rejectedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class MarineContainer {
  MarineContainer({
    required this.id,
    required this.seaShippingId,
    required this.containerCount,
    required this.content,
    required this.containerType,
    this.image,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int seaShippingId;
  int containerCount;
  String content;
  String containerType;
  String? image;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory MarineContainer.fromJson(Map<String, dynamic> json) =>
      MarineContainer(
        id: json['id'],
        seaShippingId: json['sea_shipping_id'],
        containerCount: json['container_count'],
        content: json['content'],
        containerType: json['container_type'],
        image: json['image'],
        deletedAt: json['deleted_at'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sea_shipping_id': seaShippingId,
        'container_count': containerCount,
        'content': content,
        'container_type': containerType,
        'image': image,
        'deleted_at': deletedAt,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class MarineGoods {
  MarineGoods({
    required this.id,
    required this.seaShippingId,
    required this.through,
    this.totalWeight,
    this.overallSize,
    required this.quantity,
    required this.unitType,
    required this.length,
    required this.width,
    required this.height,
    required this.cm,
    required this.weightPerUnit,
    this.image,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int seaShippingId;
  String through;
  String? totalWeight;
  String? overallSize;
  String? quantity;
  String? unitType;
  String? length;
  String? width;
  String? height;
  String? cm;
  String? weightPerUnit;
  String? image;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory MarineGoods.fromJson(Map<String, dynamic> json) => MarineGoods(
        id: json['id'],
        seaShippingId: json['sea_shipping_id'],
        through: json['through'],
        totalWeight: json['total_weight'],
        overallSize: json['overall_size'],
        quantity: json['quantity'],
        unitType: json['unit_type'],
        length: json['length'],
        width: json['width'],
        height: json['height'],
        cm: json['cm'],
        weightPerUnit: json['weight_per_unit'],
        image: json['image'],
        deletedAt: json['deleted_at'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sea_shipping_id': seaShippingId,
        'through': through,
        'total_weight': totalWeight,
        'overall_size': overallSize,
        'quantity': quantity,
        'unit_type': unitType,
        'length': length,
        'width': width,
        'height': height,
        'cm': cm,
        'weight_per_unit': weightPerUnit,
        'image': image,
        'deleted_at': deletedAt,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
