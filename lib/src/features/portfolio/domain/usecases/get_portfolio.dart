import 'package:injectable/injectable.dart';

import '../entities/portfolio.dart';
import '../repositories/portfolio_repository.dart';

@injectable
class GetPortfolioUseCase {
  final PortfolioRepository repository;

  const GetPortfolioUseCase(this.repository);

  Future<PortfolioEntity> call() {
    return repository.fetchPortfolio();
  }
}
