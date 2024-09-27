import 'package:coraapp/services/firebase_service.dart';
import 'package:coraapp/services/map_service.dart';
import 'package:get/get.dart';

import '../../models/baseModel/base_model.dart';
import '../../services/web_service.dart';

class APIController extends GetxController {
  var isLoading = false.obs;
  var baseModel = BaseModel().obs;
  var webservice = Webservice();
  var mapService = MapService();
  var firebaseService = FirebaseService();
}
