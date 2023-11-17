class InvoiceData {
  final String orderId,
      ship,
      typeGoods,
      ladingNumber,
      containerCount,
      weight,
      importListNumber,
      importListDate,
      totalWithoutTax,
      totalTax,
      total,
      note;

  final List<String> service, totals;
  const InvoiceData({
    required this.orderId,
    required this.totals,
    required this.service,
    required this.total,
    required this.totalTax,
    required this.totalWithoutTax,
    required this.importListNumber,
    required this.weight,
    required this.containerCount,
    required this.typeGoods,
    required this.ship,
    required this.note,
    required this.importListDate,
    required this.ladingNumber,
  });

  Map<String, dynamic> toJson() => {
        'ship': ship,
        'type_goods': typeGoods,
        'lading_number': ladingNumber,
        'container_count': containerCount,
        'weight': weight,
        'import_list_number': importListNumber,
        'import_list_date': importListDate,
        'total_without_tax': totalWithoutTax,
        'total_tax': totalTax,
        'total': total,
        'note': note,
      };
}
