import 'dart:convert';

import 'package:hotel/core/error/exception.dart';
import 'package:hotel/feature/data/models/booking_models.dart';
import 'package:http/http.dart' as http;

abstract class BookingRemoteDataSource {
  Future<BookingModels> getBooking();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;

  BookingRemoteDataSourceImpl({required this.client});

  @override
  Future<BookingModels> getBooking() async {
    String url = 'https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8';
    final response = await client.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if(response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return BookingModels.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

}