import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/order_details/presentation/bottom_sheets/items_of_invoice_sheet.dart';
import 'package:khalsha/features/order_details/presentation/view.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/inputs/text_field_input_with_holder.dart';
import 'package:khalsha/features/widgets/stylish_text.dart';

import '../../../../core/data/source/local/lang_locale.dart';
import '../../../widgets/inputs/service_item_with_holder.dart';

class CreateBill extends StatefulWidget {
  const CreateBill({Key? key}) : super(key: key);

  @override
  State<CreateBill> createState() => _CreateBillState();
}

class _CreateBillState extends State<CreateBill> {
  final controller = Get.find<OrderDetailsController>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        children: [
          const Divider(),
          const TextUnderline('إنشاء الفاتورة'),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'الباخرة',
              controller: controller.ship,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.ship.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'رقم البوليصة',
              controller: controller.landingNumber,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.landingNumber.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'نوع البضاعة',
              controller: controller.typeGoods,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.typeGoods.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'عدد الحاويات',
              controller: controller.containerCount,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.containerCount.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'الوزن',
              controller: controller.weight,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.weight.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'رقم بيان الاستيراد',
              controller: controller.importListNumber,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.importListNumber.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) => ServiceItemWithHolder(
              title: 'تاريخ بيان الاستيراد',
              text: controller.importListDate == null ? null : 'تم',
              onTap: () => _chooseDateTime(field),
              errorMsg: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.importListDate.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'الاجمالي بدون ضريبة القيمة المضافة',
              controller: controller.totalWithoutTax,
              keyboardType: TextInputType.number,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.totalWithoutTax.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'اجمالي ضريبة القيمة المضافة',
              controller: controller.totalTax,
              keyboardType: TextInputType.number,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.totalTax.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'الاجمالى',
              controller: controller.total,
              keyboardType: TextInputType.number,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.total.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) =>
                TextFieldInputWithHolder(
              title: 'ملاحظات',
              maxLines: 5,
              controller: controller.notes,
              onSaved: (String? value) => field.didChange(value),
              errorText: field.errorText,
            ),
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.notes.name,
          ),
          FormBuilderField(
            builder: (FormFieldState<dynamic> field) => ServiceItemWithHolder(
              title: 'بنود/ محتوي الفاتورة',
              body: const ItemsOfInvoiceSheet(),
              height: Get.height / 1.2,
              text: field.value != '' ? 'تم' : null,
              errorMsg: field.errorText,
            ),
            onSaved: (String? value) {
              final hasEmptyInputs = controller.invoiceItems.any(
                (element) =>
                    element.totalTaxs.text.isEmpty ||
                    element.totalWithoutTaxs.text.isEmpty ||
                    element.totals.text.isEmpty ||
                    element.service.text.isEmpty ||
                    element.containerNumbers.text.isEmpty ||
                    element.totalPercents.text.isEmpty,
              );
              controller.didFieldChanged(
                InvoiceInputsKeys.invoiceItems.name,
                value: hasEmptyInputs ? '' : 'x',
              );
            },
            validator: FormBuilderValidators.required(),
            name: InvoiceInputsKeys.invoiceItems.name,
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          CustomButton(
            width: Get.width,
            onTap: controller.createInvoice,
            loading: controller.createInvoiceLoading,
            text: 'إنشاء/تحديث الفاتورة',
          )
        ],
      ),
    );
  }

  void _chooseDateTime(FormFieldState<dynamic> field) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now().add(const Duration(days: 1)),
      maxTime: DateTime.now().add(const Duration(days: 10)),
      onConfirm: (DateTime date) {
        controller.importListDate = date;
        field.didChange(date.toString());
        setState(() {});
      },
      currentTime: controller.importListDate,
      locale: Lang.instance.isEn ? LocaleType.en : LocaleType.ar,
    );
  }
}

enum InvoiceInputsKeys {
  ship,
  landingNumber,
  typeGoods,
  containerCount,
  weight,
  importListNumber,
  importListDate,
  totalWithoutTax,
  totalTax,
  total,
  notes,
  invoiceItems;
}
