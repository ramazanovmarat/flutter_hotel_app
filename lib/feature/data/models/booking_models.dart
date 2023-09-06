import 'package:hotel/feature/domain/entities/booking_entity.dart';

class BookingModels extends BookingEntity {
  BookingModels({
      required id,
      required hotel_name,
      required hotel_adress,
      required horating,
      required rating_name,
      required departure,
      required arrival_country,
      required tour_date_start,
      required tour_date_stop,
      required number_of_nights,
      required room,
      required nutrition,
      required tour_price,
      required fuel_charge,
      required service_charge
  }) : super (
    id: id,
    hotel_name: hotel_name,
    hotel_adress: hotel_adress,
    horating: horating,
    rating_name: rating_name,
    departure: departure,
    arrival_country: arrival_country,
    tour_date_start: tour_date_start,
    tour_date_stop: tour_date_stop,
    number_of_nights: number_of_nights,
    room: room,
    nutrition: nutrition,
    tour_price: tour_price,
    fuel_charge: fuel_charge,
    service_charge: service_charge,
  );

  factory BookingModels.fromJson(Map<String, dynamic> json) {
    return BookingModels(id: json['id'],
        hotel_name: json['hotel_name'],
        hotel_adress: json['hotel_adress'],
        horating: json['horating'],
        rating_name: json['rating_name'],
        departure: json['departure'],
        arrival_country: json['arrival_country'],
        tour_date_start: json['tour_date_start'],
        tour_date_stop: json['tour_date_stop'],
        number_of_nights: json['number_of_nights'],
        room: json['room'],
        nutrition: json['nutrition'],
        tour_price: json['tour_price'],
        fuel_charge: json['fuel_charge'],
        service_charge: json['service_charge'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hotel_name'] = hotel_name;
    data['hotel_adress'] = hotel_adress;
    data['horating'] = horating;
    data['rating_name'] = rating_name;
    data['departure'] = departure;
    data['arrival_country'] = arrival_country;
    data['tour_date_start'] = tour_date_start;
    data['tour_date_stop'] = tour_date_stop;
    data['number_of_nights'] = number_of_nights;
    data['room'] = room;
    data['nutrition'] = nutrition;
    data['tour_price'] = tour_price;
    data['fuel_charge'] = fuel_charge;
    data['service_charge'] = service_charge;
    return data;
  }
}