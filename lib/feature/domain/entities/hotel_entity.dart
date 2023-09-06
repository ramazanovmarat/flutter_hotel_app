import 'package:equatable/equatable.dart';

class HotelEntity extends Equatable {
  final int? id;
  final String? name;
  final String? adress;
  final int? minimal_price;
  final String? price_for_it;
  final int? rating;
  final String? rating_name;
  final List<String>? image_urls;
  final String? description;
  final List<String>? peculiarities;

  const HotelEntity({
      required this.id,
      required this.name,
      required this.adress,
      required this.minimal_price,
      required this.price_for_it,
      required this.rating,
      required this.rating_name,
      required this.image_urls,
      required this.description,
      required this.peculiarities
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    adress,
    minimal_price,
    price_for_it,
    rating,
    rating_name,
    image_urls,
    description,
    peculiarities
  ];
}