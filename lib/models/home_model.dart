import 'dart:convert';
import 'package:coraapp/utils/utils.dart';

/// wallet : 0
/// orders : [{"id":1,"name":"Recipient 1","phone":"09007875601","description":"Test Order","package_type":"Box","order_id":"HdStaW","order_status":"accepted","user_id":"2","rider_id":"3","total_amount":"100","discounted_amount":"0","payment_method":"Cash on Delivery","pickup_address":"people' colony","pickup_latitude":"31.4321498000","pickup_longitude":"74.2766182000","drop_address":"Wapda Town","drop_latitude":"31.4319352000","drop_longitude":"74.2617481000","created_at":"2023-01-03T10:56:32.000000Z","updated_at":"2023-01-03T10:58:09.000000Z"}]

class HomeModel {
  HomeModel._();

  dynamic wallet;
  List<OrdersBean>? orders;

  static HomeModel fromMap(Map<String, dynamic> map) {
    HomeModel homeModelBean = HomeModel._();
    homeModelBean.wallet = map['wallet'] ?? 0;
    homeModelBean.orders = ((map['orders'] ?? []) as List)
        .map((o) => OrdersBean.fromMap(o ?? {}))
        .toList();
    return homeModelBean;
  }

  Map toJson() => {
        "wallet": wallet,
        "orders": orders,
      };
}

class OrdersBean {
  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic description;
  dynamic packageType;
  dynamic orderId;
  dynamic orderStatus;
  dynamic userId;
  dynamic riderId;
  dynamic totalAmount;
  dynamic discountedAmount;
  dynamic paymentMethod;
  dynamic pickupAddress;
  dynamic pickupLatitude;
  dynamic pickupLongitude;
  dynamic dropAddress;
  dynamic dropLatitude;
  dynamic dropLongitude;
  dynamic createdAt;
  dynamic updatedAt;

  static OrdersBean fromMap(Map<String, dynamic> map) {
    OrdersBean ordersBean = OrdersBean();
    ordersBean.id = map['id'] ?? 0;
    ordersBean.name = map['name'] ?? "";
    ordersBean.phone = map['phone'] ?? "";
    ordersBean.description = map['description'] ?? "";
    ordersBean.packageType = map['package_type'] ?? "";
    ordersBean.orderId = map['order_id'] ?? "";
    ordersBean.orderStatus = map['order_status'] ?? "";
    ordersBean.userId = map['user_id'] ?? "";
    ordersBean.riderId = map['rider_id'] ?? "";
    ordersBean.totalAmount = map['total_amount'] ?? "";
    ordersBean.discountedAmount = map['discounted_amount'] ?? "";
    ordersBean.paymentMethod = map['payment_method'] ?? "";
    ordersBean.pickupAddress = map['pickup_address'] ?? "";
    ordersBean.pickupLatitude = map['pickup_latitude'] ?? "";
    ordersBean.pickupLongitude = map['pickup_longitude'] ?? "";
    ordersBean.dropAddress = map['drop_address'] ?? "";
    ordersBean.dropLatitude = map['drop_latitude'] ?? "";
    ordersBean.dropLongitude = map['drop_longitude'] ?? "";
    ordersBean.createdAt = map['created_at'] ?? "";
    ordersBean.updatedAt = map['updated_at'] ?? "";
    return ordersBean;
  }

  Map toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "description": description,
        "package_type": packageType,
        "order_id": orderId,
        "order_status": orderStatus,
        "user_id": userId,
        "rider_id": riderId,
        "total_amount": totalAmount,
        "discounted_amount": discountedAmount,
        "payment_method": paymentMethod,
        "pickup_address": pickupAddress,
        "pickup_latitude": pickupLatitude,
        "pickup_longitude": pickupLongitude,
        "drop_address": dropAddress,
        "drop_latitude": dropLatitude,
        "drop_longitude": dropLongitude,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
