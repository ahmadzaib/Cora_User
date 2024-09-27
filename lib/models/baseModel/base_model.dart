import '../../utils/utils.dart';

class BaseModel {
  bool? status;
  String? code;
  String? message;
  dynamic data;

  // Factory constructor to create an instance from a Map
  static BaseModel fromMap(Map<String, dynamic>? map) {
    BaseModel baseModelBean = BaseModel();

    // Check if the map is not null and has data
    if (isNotEmpty(map)) {
      baseModelBean.data =
          map!['data'] ?? null; // Set data or null if not present
      baseModelBean.message =
          map['message'] ?? 'Something went wrong'; // Default message
      baseModelBean.code = map['code'] ?? ''; // Default empty code
      baseModelBean.status =
          map['status'] ?? false; // Default to false if status not present
    } else {
      // If map is empty, set a default error message
      baseModelBean.data = null;
      baseModelBean.message = 'Something went wrong';
      baseModelBean.code = '';
      baseModelBean.status = false; // Status should indicate an error
    }

    return baseModelBean;
  }

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
        "status": status,
      };
}
