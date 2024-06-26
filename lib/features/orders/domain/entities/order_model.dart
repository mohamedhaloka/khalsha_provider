import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/models/data_model.dart';

import '../../../../core/data/models/item_model.dart';
import '../../../order_details/data/models/offer_input_item.dart';
import '../../../order_details/data/models/order_details_item_model.dart';
import '../../../order_details/data/models/order_section_item_model.dart';
import '../../../widgets/inputs/checker_with_holder.dart';

part 'air_freight_order.dart';
part 'customs_clearance_order.dart';
part 'laboratory_order.dart';
part 'land_shipping_order.dart';
part 'marine_shipment_order.dart';
part 'ware_house_order.dart';

abstract class OrderModel {
  OrderModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.user,
    required this.offersNum,
    required this.status,
    required this.offers,
    this.offer,
    this.invoice,
    required this.certificates,
    this.invoiceUrl,
    this.certificate,
    this.feedback,
    this.orderDetails,
  });

  int id;
  String title;
  String status;
  int userId;
  User user;
  int offersNum;
  List<OfferModel> offers;
  List<DataModel> certificates;
  OfferModel? offer;
  Invoice? invoice;
  String? invoiceUrl;
  String? certificate;
  FeedbackObj? feedback;
  OrderDetailsModel? orderDetails;

  List<OrderSectionItemModel> get data => <OrderSectionItemModel>[];
  List<OrderInputItemModel> get offerInputs => <OrderInputItemModel>[];
}

class FeedbackObj {
  FeedbackObj({
    this.id,
    this.userId,
    this.ownerId,
    this.rate,
    this.feedback,
    this.formType,
    this.formId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? ownerId;
  int? rate;
  String? feedback;
  String? formType;
  int? formId;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory FeedbackObj.fromJson(Map<String, dynamic> json) => FeedbackObj(
        id: json["id"],
        userId: json["user_id"],
        ownerId: json["owner_id"],
        rate: json["rate"],
        feedback: json["feedback"],
        formType: json["form_type"],
        formId: json["form_id"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] == null || json["user"] is String
            ? null
            : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "owner_id": ownerId,
        "rate": rate,
        "feedback": feedback,
        "form_type": formType,
        "form_id": formId,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

abstract class OfferModel {
  OfferModel({
    this.id,
    this.userId,
    this.status,
    this.note,
    this.acceptedAt,
    this.rejectedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.total,
    this.orderDetails,
  });

  int? id;
  int? userId;
  String? total;
  String? status;
  String? note;
  DateTime? acceptedAt;
  dynamic rejectedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  OrderDetailsModel? orderDetails;
}

class User {
  User({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.photoProfile,
    this.bio,
    this.feedbacks,
    this.ratingsOverall,
  });

  int? id;
  String? name;
  String? photoProfile;
  String? bio;
  String? ratingsOverall;
  String? mobile;
  String? email;
  List<FeedbackObj>? feedbacks;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        photoProfile: json["photo_profile"] ?? '',
        bio: json["bio"] ?? '',
        ratingsOverall: json["ratings_overall"] ?? '',
        email: json["email"] ?? '',
        mobile: json["mobile"] ?? '',
        feedbacks: List<FeedbackObj>.from(
            (json["feedbacks"] ?? []).map((x) => FeedbackObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "photo_profile": photoProfile,
        "ratings_overall": ratingsOverall,
        "bio": bio,
      };
}

abstract class Invoice {
  Invoice({
    this.user,
    this.total,
    this.id,
    this.updatedAt,
    this.createdAt,
    this.status,
    this.note,
    this.deletedAt,
    this.userId,
  });

  int? id;
  int? userId;
  String? total;
  String? note;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  List<ItemModel> get items => <ItemModel>[];
}

class OrderFile {
  OrderFile({
    this.id,
    this.userId,
    this.file,
    this.fullPath,
    this.fileType,
    this.fileId,
    this.path,
    this.url,
    this.ext,
    this.name,
    this.size,
    this.sizeBytes,
    this.mimtype,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? file;
  String? fullPath;
  String? fileType;
  int? fileId;
  String? url;
  String? path;
  String? ext;
  String? name;
  String? size;
  int? sizeBytes;
  String? mimtype;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OrderFile.fromJson(Map<String, dynamic> json) => OrderFile(
        id: json["id"],
        userId: json["user_id"],
        file: json["file"],
        fullPath: json["full_path"],
        fileType: json["file_type"],
        url: json["url"],
        fileId: json["file_id"],
        path: json["path"],
        ext: json["ext"],
        name: json["name"],
        size: json["size"],
        sizeBytes: json["size_bytes"],
        mimtype: json["mimtype"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file": file,
        "full_path": fullPath,
        "file_type": fileType,
        "file_id": fileId,
        "url": url,
        "path": path,
        "ext": ext,
        "name": name,
        "size": size,
        "size_bytes": sizeBytes,
        "mimtype": mimtype,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OrderDetailsModel {
  final int? id;
  final String? title;
  final String? status;
  final int? userId;
  final User? user;

  OrderDetailsModel({
    this.id,
    this.title,
    this.status,
    this.userId,
    this.user,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        userId: json["user_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "user_id": userId,
        "user": user?.toJson(),
      };
}
