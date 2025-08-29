import 'package:injectable/injectable.dart';

import '../../domain/entities/portfolio.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_remote_datasource.dart';

@LazySingleton(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  const PortfolioRepositoryImpl(this.remoteDataSource);

  @override
  Future<PortfolioEntity> fetchPortfolio() async {
    final dto = await remoteDataSource.fetchPortfolio();
    return dto.toEntity();
  }
}
