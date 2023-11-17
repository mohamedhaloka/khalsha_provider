import 'package:flutter/cupertino.dart';

class InvoiceItemModel {
  final TextEditingController service, totals;

  const InvoiceItemModel({
    required this.service,
    required this.totals,
  });

  factory InvoiceItemModel.newItem() => InvoiceItemModel(
        service: TextEditingController(),
        totals: TextEditingController(),
      );
}
