/*import 'package:emp_tracker/services/api.dart';
void setupLocator() {
  locator.registerLazySingleton(() => Api('users'));
}*/
import 'package:get_it/get_it.dart';
import 'package:emp_tracker/services/api.dart';
//import './core/services/api.dart';
import 'package:emp_tracker/view_model/userCRUD.dart';

GetIt locator = GetIt.instance();

void setupLocator() {
  print("in locator file");
  locator.registerLazySingleton(() => Api('users'));
  locator.registerLazySingleton(() => CRUDModel());
}
