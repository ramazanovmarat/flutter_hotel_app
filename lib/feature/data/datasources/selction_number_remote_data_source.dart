import 'dart:convert';

import 'package:hotel/core/error/exception.dart';
import 'package:hotel/feature/data/models/selection_number_models.dart';
import 'package:http/http.dart' as http;

abstract class SelectionNumberDataSource {
  Future<List<SelectionNumberModel>> getNumbers();
}

class SelectionNumberDataSourceImpl implements SelectionNumberDataSource {
  final http.Client client;

  SelectionNumberDataSourceImpl({required this.client});

  @override
  Future<List<SelectionNumberModel>> getNumbers() async {
    String url = 'https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd';
    final response = await client.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if(response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return (jsonResponse['rooms'] as List<dynamic>).map((e) => SelectionNumberModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}