import 'package:hotel/feature/domain/entities/hotel_entity.dart';

class HotelModel extends HotelEntity {
  const HotelModel({
      required id,
      required name,
      required adress,
      required minimal_price,
      required price_for_it,
      required rating,
      required rating_name,
      required image_urls,
      required description,
      required peculiarities
  }) : super (
    id: id,
    name: name,
    adress: adress,
    minimal_price: minimal_price,
    price_for_it: price_for_it,
    rating: rating,
    rating_name: rating_name,
    image_urls: image_urls,
    description: description,
    peculiarities: peculiarities,
  );

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
        id: json['id'],
        name: json['name'],
        adress: json['adress'],
        minimal_price: json['minimal_price'],
        price_for_it: json['price_for_it'],
        rating: json['rating'],
        rating_name: json['rating_name'],
        image_urls: (json['image_urls'] as List<dynamic>).map((dynamic imageUrl) => imageUrl.toString()).toList(),
        description: json['about_the_hotel']['description'],
        peculiarities: (json['about_the_hotel']['peculiarities'] as List<dynamic>).map((dynamic peculiarity) => peculiarity.toString()).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['adress'] = adress;
    data['minimal_price'] = minimal_price;
    data['price_for_it'] = price_for_it;
    data['rating'] = rating;
    data['image_urls'] = image_urls;
    data['rating_name'] = rating_name;
    data['description'] = description;
    data['peculiarities'] = peculiarities;
    return data;
  }
}