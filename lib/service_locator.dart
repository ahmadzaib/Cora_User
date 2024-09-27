import 'package:coraapp/utils/custom_validator.dart';
import 'package:coraapp/utils/form_helper.dart';
import 'package:get_it/get_it.dart';
import 'helper/Auth/auth_helper.dart';
import 'helper/FilePicker/file_picker_helper.dart';
import 'store/auth_store.dart';
import 'utils/function_response.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //Custom Utilities
  getIt.registerFactory(() => FunctionResponse());
  getIt.registerFactory(() => CustomValidator());
  getIt.registerFactory(() => CustomFormHelper());

  getIt.registerSingleton(AuthScreenStore());
  getIt.registerSingleton(AuthHelper());

  getIt.registerFactory(() => FilePickerHelper(
        getIt<AuthScreenStore>(),
      ));
}
