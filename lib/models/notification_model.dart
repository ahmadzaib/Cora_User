class NotificationModel {
  int? id;
  dynamic userId;
  dynamic orderId;
  dynamic riderId;
  dynamic title;
  dynamic body;
  dynamic createdAt;
  dynamic updatedAt;

  static NotificationModel fromMap(Map<String, dynamic> map) {
    NotificationModel notificationModelBean = NotificationModel();
    notificationModelBean.id = map['id']??0;
    notificationModelBean.userId = map['user_id']??'';
    notificationModelBean.orderId = map['order_id']??'';
    notificationModelBean.riderId = map['rider_id']??'';
    notificationModelBean.title = map['title']??'';
    notificationModelBean.body = map['body']??'';
    notificationModelBean.createdAt = map['created_at']??'';
    notificationModelBean.updatedAt = map['updated_at']??'';
    return notificationModelBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "rider_id": riderId,
    "title": title,
    "body": body,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}