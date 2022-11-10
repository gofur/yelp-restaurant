import 'package:restaurant/base/bloc.dart';
import 'package:restaurant/restaurant/repo/model.dart';
import 'package:restaurant/restaurant/repo/restaurant_api.dart';
import 'package:restaurant/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class RestaurantBloc extends Bloc {
  final _restaurantApi = serviceLocator<RestaurantApi>();

  // initial variable
  final _restaurantController = BehaviorSubject<BusinessListRestModel?>();
  final _restaurantDetailController = BehaviorSubject<BusinessRestModel?>();
  //set stream product
  Stream<BusinessListRestModel?> get restaurants => _restaurantController.stream;
  Stream<BusinessRestModel?> get restaurant => _restaurantDetailController.stream;

  Future<void> fetchRestaurant(String latitude, String longitude, String terms) async {
    try {
      var _restaurant = await _restaurantApi.fetchData(latitude, longitude, terms);
      _restaurantController.add(_restaurant);
    } catch (e) {
      _restaurantController.addError(e);
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      var _restaurantDetail = await _restaurantApi.fetchDetail(id);
      _restaurantDetailController.add(_restaurantDetail);
    } catch (e) {
      _restaurantDetailController.addError(e);
    }
  }

  Future<void> clearDetail() async {
    _restaurantDetailController.add(null);
  }

  @override
  void dispose() {
    _restaurantController.close();
    _restaurantDetailController.close();
  }
}