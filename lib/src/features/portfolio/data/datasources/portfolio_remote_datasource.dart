import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../models/portfolio_models.dart';

abstract class PortfolioRemoteDataSource {
  Future<PortfolioDto> fetchPortfolio();
}

@LazySingleton(as: PortfolioRemoteDataSource)
class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  static const String endpoint = 'https://dummyjson.com/c/60b7-70a6-4ee3-bae8';

  final http.Client client;

  PortfolioRemoteDataSourceImpl(this.client);

  @override
  Future<PortfolioDto> fetchPortfolio() async {
    final url = Uri.parse(endpoint);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) {
        return PortfolioDto.fromJson(decoded);
      }
      throw Exception('Unexpected portfolio payload shape');
    }
    throw Exception('Failed to fetch portfolio: ${response.statusCode}');
  }
}
