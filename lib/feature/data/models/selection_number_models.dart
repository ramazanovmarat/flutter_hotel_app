import 'package:hotel/feature/domain/entities/selection_number_entity.dart';

class SelectionNumberModel extends SelectionNumberEntity {
  const SelectionNumberModel({
      required id,
      required name,
      required price,
      required price_per,
      required peculiarities,
      required image_urls
  }) : super(
    id: id,
    name: name,
    price: price,
    price_per: price_per,
    peculiarities: peculiarities,
    image_urls: image_urls,
  );

  factory SelectionNumberModel.fromJson(Map<String, dynamic> json) {
    return SelectionNumberModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      price_per: json['price_per'],
      peculiarities: (json['peculiarities'] as List<dynamic>).map((dynamic e) => e.toString()).toList(),
      image_urls: (json['image_urls'] as List<dynamic>).map((dynamic e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['price_per'] = price_per;
    data['peculiarities'] = peculiarities;
    data['image_urls'] = image_urls;
    return data;
  }
}