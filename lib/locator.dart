/*import 'package:emp_tracker/services/api.dart';
void setupLocator() {
  locator.registerLazySingleton(() => Api('users'));
}*/
import 'package:get_it/get_it.dart';
import 'package:emp_tracker/services/api.dart';
//import './core/services/api.dart';
//import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('users'));
  //locator.registerLazySingleton(() => CRUDModel()) ;
}