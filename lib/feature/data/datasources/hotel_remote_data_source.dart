import 'dart:convert';

import 'package:hotel/core/error/exception.dart';
import 'package:hotel/feature/data/models/hotel_models.dart';
import 'package:http/http.dart' as http;

abstract class HotelRemoteDataSource {
  Future<HotelModel> getHotels();
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final http.Client client;

  HotelRemoteDataSourceImpl({required this.client});

  @override
  Future<HotelModel> getHotels() async {
    String url = 'https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3';
    final response = await client.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if(response.statusCode == 200) {
      final hotels = jsonDecode(response.body);
      return HotelModel.fromJson(hotels);
    } else {
      throw ServerException();
    }
  }
}