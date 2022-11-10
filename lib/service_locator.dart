
import 'package:get_it/get_it.dart';
import 'package:restaurant/restaurant/bloc.dart';
import 'package:restaurant/restaurant/repo/restaurant_api.dart';
import 'package:restaurant/utils/helper/location_helper.dart';
import 'package:restaurant/utils/helper/permission_handler.dart';

GetIt get serviceLocator => GetIt.instance;

void initServiceLocator() {
//APIS
  serviceLocator.registerSingleton<RestaurantApi>(RestaurantApi());

//BLOCS
  serviceLocator.registerSingleton<RestaurantBloc>(RestaurantBloc());

//SERVICES
  serviceLocator.registerSingleton<LocationService>(LocationService());
  serviceLocator.registerSingleton<PermissionHelper>(PermissionHelper());
}