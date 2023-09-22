part of '../view.dart';

class _BillDataTab extends GetView<OrderDetailsController> {
  const _BillDataTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoice = controller.orderModel.invoice;
    final feedback = controller.orderModel.feedback;
    return ListView(
      padding: const EdgeInsets.only(top: 30),
      children: [
        const OrderTabHeader(
          title: 'الفاتورة',
          hint: 'هنا بتم تحديد فاتورتك و إرسالها للعميل',
        ),
        if (controller.orderModel.invoice == null &&
            controller.serviceType != ServiceTypes.customsClearance)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CustomButton(
              onTap: controller.createInvoice,
              loading: controller.createInvoiceLoading,
              text: 'إنشاء الفاتورة',
            ),
          ),
        if (invoice != null) ...[
          if (feedback != null) ...[
            _UserRate(feedback),
          ],
          Bill(
            items: invoice.items,
            total: invoice.total.toString(),
            orderId: invoice.id.toString(),
            userName: invoice.user!.name!,
            billCreatedDate: invoice.createdAt.toString(),
            userBio: invoice.user!.bio!,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12),
          //   child: CustomButton(
          //     loading: controller.showInvoiceLoading,
          //     onTap: () {
          //       String url =
          //           '${HttpService.baseURL}importer/${controller.serviceType.value}/download/invoice/${orderData.id}';
          //       dev.log(url, name: 'INVOICE URL');
          //
          //       controller.showInvoice(url);
          //     },
          //     text: 'مشاهدة الفاتورة',
          //   ),
          // ),
        ],
      ],
    );
  }
}

class _UserRate extends StatelessWidget {
  const _UserRate(this.feedback, {Key? key}) : super(key: key);
  final FeedbackObj? feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const TextUnderline('تقييم العميل'),
        Row(
          children: [
            Expanded(child: Text(feedback?.feedback ?? '')),
            RatingBar.builder(
              initialRating: feedback?.rate?.toDouble() ?? 0.0,
              minRating: 1,
              glow: false,
              itemSize: 20,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: ColorManager.primaryColor,
              ),
              onRatingUpdate: (_) => _,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
