import 'package:equatable/equatable.dart';

class BusinessListRestModel extends Equatable {
  final List<BusinessRestModel> businesses;

  const BusinessListRestModel({required this.businesses});

  @override
  List<Object> get props => [businesses];

  factory BusinessListRestModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonBusinesses = json["businesses"];
    final List<BusinessRestModel> businesses = jsonBusinesses.map((jsonBusiness) {
      return BusinessRestModel.fromJson(jsonBusiness);
    }).toList();

    return BusinessListRestModel(
      businesses: businesses,
    );
  }
}

class BusinessRestModel extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final int reviewCount;
  final List<CategoryRestModel> categories;
  final double rating;
  final String? price;
  final String? phone;
  final LocationRestModel location;
  final List<HourRestModel>? hours;

  const BusinessRestModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.price,
    required this.location,
    required this.hours,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, photoUrl, rating, reviewCount, location, price, categories, hours, phone];

  factory BusinessRestModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonCategories = json["categories"];
    final List<CategoryRestModel> categories = jsonCategories.map((jsonCategory) {
      return CategoryRestModel.fromJson(jsonCategory);
    }).toList();

    final List<dynamic>? jsonHours = json["hours"];
    final List<HourRestModel>? hours = jsonHours?.map((jsonHour) {
      return HourRestModel.fromJson(jsonHour);
    }).toList();

    return BusinessRestModel(
      id: json["id"],
      name: json["name"],
      photoUrl: json["image_url"],
      reviewCount: json["review_count"],
      categories: categories,
      rating: json["rating"],
      price: json["price"],
      phone: json["phone"],
      location: LocationRestModel.fromJson(json["location"]),
      hours: hours,
    );
  }
}

class CategoryRestModel extends Equatable {
  final String title;

  const CategoryRestModel({required this.title});

  @override
  List<Object> get props => [title];

  factory CategoryRestModel.fromJson(Map<String, dynamic> json) {
    return CategoryRestModel(
      title: json["title"],
    );
  }
}

class LocationRestModel extends Equatable {
  final String address;
  final String city;

  const LocationRestModel({
    required this.address,
    required this.city,
  });

  @override
  List<Object> get props => [address, city];

  factory LocationRestModel.fromJson(Map<String, dynamic> json) {
    return LocationRestModel(
      address: json["address1"],
      city: json["city"],
    );
  }
}

class HourRestModel extends Equatable {
  final List<OpenRestModel> opens;
  final String hoursType;
  final bool isOpenNow;

  const HourRestModel({required this.opens,required this.hoursType,required this.isOpenNow});

  @override
  List<Object> get props => [opens, hoursType, isOpenNow];

  factory HourRestModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonOpens = json["open"];
    final List<OpenRestModel> opens = jsonOpens.map((jsonOpen) {
      return OpenRestModel.fromJson(jsonOpen);
    }).toList();

    return HourRestModel(
      opens: opens,
      hoursType: json["hours_type"],
      isOpenNow: json["is_open_now"],
    );
  }
}

class OpenRestModel extends Equatable {
  final String start;
  final String end;
  final int day;

  const OpenRestModel({
    required this.start,
    required this.end,
    required this.day
  });

  @override
  List<Object> get props => [start, end, day];

  factory OpenRestModel.fromJson(Map<String, dynamic> json) {
    return OpenRestModel(
      start: json["start"],
      end: json["end"],
      day: json["day"]
    );
  }
}
