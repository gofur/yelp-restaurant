import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/restaurant/bloc.dart';
import 'package:restaurant/restaurant/repo/model.dart';
import 'package:restaurant/restaurant/widgets/restaurant_detail.dart';
import 'package:restaurant/service_locator.dart';
import 'package:restaurant/utils/helper/location_helper.dart';
import 'package:restaurant/utils/helper/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        child: Scaffold(
            appBar: AppBar(title: const Text("Restaurant")),
            body: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "All Restaurant",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RestaurantListHome(),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class RestaurantListHome extends StatefulWidget {
  const RestaurantListHome({Key? key}) : super(key: key);

  @override
  State<RestaurantListHome> createState() => _RestaurantListHomeState();
}

class _RestaurantListHomeState extends State<RestaurantListHome> {
  //initial bloc
  final _restaurantBloc = serviceLocator<RestaurantBloc>();
  final _locationService = serviceLocator<LocationService>();
  final _permission = serviceLocator<PermissionHelper>();

  Future<void> initGetLocationPermissions() async {
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        var isGranted =
            await _permission.requestPermission(Permission.locationWhenInUse);
        if (isGranted) {
          var currentLocation = await _locationService.getLocationData();
          _restaurantBloc.fetchRestaurant(currentLocation.latitude.toString(),
              currentLocation.longitude.toString(), 'nasi goreng');
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED' || e.code == 'SERVICE_STATUS_ERROR') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initGetLocationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BusinessListRestModel?>(
        stream: _restaurantBloc.restaurants,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BusinessListRestModel? data = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data?.businesses.length,
                itemBuilder: (BuildContext context, int position) {
                  BusinessRestModel restaurant = data!.businesses[position];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RestaurantDetail(id: restaurant.id, restaurantName: restaurant.name)));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x26000000),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0)),
                                  child: CachedNetworkImage(
                                    imageUrl: restaurant.photoUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Rating: ",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.grey,fontWeight: FontWeight.bold),
                                          ),
                                          Text(restaurant.rating.toString(),
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 14.0, color: Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Phone: ",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.grey,fontWeight: FontWeight.bold),
                                          ),
                                          Text(restaurant.phone.toString(),
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
