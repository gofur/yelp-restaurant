import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/restaurant/bloc.dart';
import 'package:restaurant/restaurant/repo/model.dart';
import 'package:restaurant/service_locator.dart';

class RestaurantDetail extends StatefulWidget {
  final String id;
  final String restaurantName;
  const RestaurantDetail(
      {Key? key, required this.id, required this.restaurantName})
      : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  //initial bloc
  final _restaurantBloc = serviceLocator<RestaurantBloc>();

  @override
  void initState() {
    super.initState();
    _restaurantBloc.clearDetail();
    _restaurantBloc.fetchRestaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text(widget.restaurantName)),
          body: SafeArea(
            child: StreamBuilder<BusinessRestModel?>(
                stream: _restaurantBloc.restaurant,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    BusinessRestModel restaurant = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 2.0 / 1.5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            child: CachedNetworkImage(
                              imageUrl: restaurant.photoUrl,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            restaurant.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          child: Row(
                            children: [
                              const Text(
                                "Rating: ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.bold),
                              ),
                              Text(restaurant.rating.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          child: Row(
                            children: [
                              const Text(
                                "Phone: ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.bold),
                              ),
                              Text(restaurant.phone.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          child: Row(
                            children: [
                              const Text(
                                "Status: ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.bold),
                              ),
                              Text(restaurant.hours![0].isOpenNow == true ? "Open" : "Close",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          child: Row(
                            children: [
                              const Text(
                                "Hour Type: ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.bold),
                              ),
                              Text(restaurant.hours![0].hoursType,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if(snapshot.hasError) {
                    return const SizedBox.shrink();
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}
