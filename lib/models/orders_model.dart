

class OrdersModel {
  OrdersModel._();
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
  dynamic picked_at;
  dynamic drop_at;
  dynamic createdAt;
  dynamic updatedAt;
  RiderBean? rider;
  UserBean? user;


  static OrdersModel fromMap(Map<String, dynamic> map) {
    OrdersModel ordersModelBean = OrdersModel._();
    ordersModelBean.id = map['id']??0;
    ordersModelBean.name = map['name']??"";
    ordersModelBean.phone = map['phone']??"";
    ordersModelBean.description = map['description']??"";
    ordersModelBean.packageType = map['package_type']??"";
    ordersModelBean.orderId = map['order_id']??"";
    ordersModelBean.orderStatus = map['order_status']??"";
    ordersModelBean.userId = map['user_id']??"";
    ordersModelBean.riderId = map['rider_id']??"";
    ordersModelBean.totalAmount = map['total_amount']??"";
    ordersModelBean.discountedAmount = map['discounted_amount']??"";
    ordersModelBean.paymentMethod = map['payment_method']??"";
    ordersModelBean.pickupAddress = map['pickup_address']??"";
    ordersModelBean.pickupLatitude = map['pickup_latitude']??"";
    ordersModelBean.pickupLongitude = map['pickup_longitude']??"";
    ordersModelBean.dropAddress = map['drop_address']??"";
    ordersModelBean.dropLatitude = map['drop_latitude']??"";
    ordersModelBean.dropLongitude = map['drop_longitude']??"";
    ordersModelBean.drop_at = map['drop_at']??"2023-01-03T10:56:32.000000Z";
    ordersModelBean.picked_at = map['picked_at']??"2023-01-03T10:56:32.000000Z";
    ordersModelBean.createdAt = map['created_at']??"2023-01-03T10:56:32.000000Z";
    ordersModelBean.updatedAt = map['updated_at']??"023-01-03T10:58:09.000000Z";
    ordersModelBean.rider = RiderBean.fromMap(map['rider']??{});
    ordersModelBean.user = UserBean.fromMap(map['user']??{});

    return ordersModelBean;
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
    "picked_at": picked_at,
    "drop_at": drop_at,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "rider": rider,
    "user": user,
  };
}

class UserBean {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic profileImage;

  static UserBean fromMap(Map<String, dynamic> map) {
    UserBean userBean = UserBean();
    userBean.id = map['id']??0;
    userBean.name = map['name']??"";
    userBean.email = map['email']??"";
    userBean.phone = map['phone']??"";
    userBean.profileImage = map['profile_image']??"";
    return userBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_image": profileImage,
  };
}
class RiderBean {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic profileImage;

  static RiderBean fromMap(Map<String, dynamic> map) {
    RiderBean riderBean = RiderBean();
    riderBean.id = map['id']??"";
    riderBean.name = map['name']??"";
    riderBean.email = map['email']??"";
    riderBean.phone = map['phone']??"";
    riderBean.profileImage = map['profile_image']??"";
    return riderBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_image": profileImage,
  };
}
