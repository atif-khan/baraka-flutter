import '../entities/portfolio.dart';

abstract class PortfolioRepository {
  Future<PortfolioEntity> fetchPortfolio();
}
