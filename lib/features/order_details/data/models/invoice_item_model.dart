import 'package:flutter/cupertino.dart';

class InvoiceItemModel {
  final TextEditingController service,
      containerNumbers,
      totals,
      totalWithoutTaxs,
      totalTaxs,
      totalPercents;

  const InvoiceItemModel({
    required this.service,
    required this.containerNumbers,
    required this.totalPercents,
    required this.totals,
    required this.totalTaxs,
    required this.totalWithoutTaxs,
  });

  factory InvoiceItemModel.newItem() => InvoiceItemModel(
        service: TextEditingController(),
        containerNumbers: TextEditingController(),
        totalPercents: TextEditingController(),
        totals: TextEditingController(),
        totalTaxs: TextEditingController(),
        totalWithoutTaxs: TextEditingController(),
      );
}
