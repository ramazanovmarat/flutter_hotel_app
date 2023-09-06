import 'package:equatable/equatable.dart';

class SelectionNumberEntity extends Equatable{
  final int? id;
  final String? name;
  final int? price;
  final String? price_per;
  final List<String>? peculiarities;
  final List<String>? image_urls;

  const SelectionNumberEntity({
      required this.id,
      required this.name,
      required this.price,
      required this.price_per,
      required this.peculiarities,
      required this.image_urls
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    price,
    price_per,
    peculiarities,
    image_urls
  ];
}