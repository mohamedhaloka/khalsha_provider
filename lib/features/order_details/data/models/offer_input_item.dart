import 'package:flutter/cupertino.dart';

class OrderInputItemModel {
  final String? title;
  final String field;
  final bool isRequired;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget Function(TextEditingController)? child;
  OrderInputItemModel({
    required this.textInputType,
    required this.field,
    required this.controller,
    this.isRequired = true,
    this.title,
    this.child,
  });
}
