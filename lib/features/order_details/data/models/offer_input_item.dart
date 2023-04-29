import 'package:flutter/cupertino.dart';

class OrderInputItemModel {
  final String title;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget Function(TextEditingController)? child;
  OrderInputItemModel({
    required this.textInputType,
    required this.title,
    required this.controller,
    this.child,
  });
}
