import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final int? id;
  final String? hotel_name;
  final String? hotel_adress;
  final int? horating;
  final String? rating_name;
  final String? departure;
  final String? arrival_country;
  final String? tour_date_start;
  final String? tour_date_stop;
  final int? number_of_nights;
  final String? room;
  final String? nutrition;
  final int? tour_price;
  final int? fuel_charge;
  final int? service_charge;

  const BookingEntity({
      required this.id,
      required this.hotel_name,
      required this.hotel_adress,
      required this.horating,
      required this.rating_name,
      required this.departure,
      required this.arrival_country,
      required this.tour_date_start,
      required this.tour_date_stop,
      required this.number_of_nights,
      required this.room,
      required this.nutrition,
      required this.tour_price,
      required this.fuel_charge,
      required this.service_charge
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    hotel_name,
    hotel_adress,
    horating,
    rating_name,
    departure,
    arrival_country,
    tour_date_start,
    tour_date_stop,
    number_of_nights,
    room,
    nutrition,
    tour_price,
    fuel_charge,
    service_charge
  ];
}