import 'package:baraka/src/features/portfolio/data/datasources/portfolio_remote_datasource.dart';
import 'package:baraka/src/features/portfolio/data/models/portfolio_models.dart';
import 'package:baraka/src/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:baraka/src/features/portfolio/domain/entities/portfolio.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPortfolioRemoteDataSource implements PortfolioRemoteDataSource {
  PortfolioDto? _returnValue;
  Exception? _throwException;

  void setReturnValue(PortfolioDto value) {
    _returnValue = value;
    _throwException = null;
  }

  void setException(Exception exception) {
    _throwException = exception;
    _returnValue = null;
  }

  @override
  Future<PortfolioDto> fetchPortfolio() async {
    if (_throwException != null) {
      throw _throwException!;
    }
    return _returnValue!;
  }
}

void main() {
  late PortfolioRepositoryImpl repository;
  late MockPortfolioRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPortfolioRemoteDataSource();
    repository = PortfolioRepositoryImpl(mockDataSource);
  });

  group('PortfolioRepositoryImpl', () {
    test('should fetch portfolio from remote data source', () async {
      // arrange
      final dto = PortfolioDto(
        balance: BalanceDto(
          netValue: 1000.0,
          pnl: 100.0,
          pnlPercentage: 10.0,
        ),
        positions: [
          PositionDto(
            instrument: InstrumentDto(
              ticker: 'AAPL',
              name: 'Apple Inc.',
              exchange: 'NASDAQ',
              currency: 'USD',
              lastTradedPrice: 150.0,
            ),
            quantity: 10.0,
            averagePrice: 100.0,
            cost: 1000.0,
            marketValue: 1500.0,
            pnl: 500.0,
            pnlPercentage: 50.0,
          ),
        ],
      );

      mockDataSource.setReturnValue(dto);

      // act
      final result = await repository.fetchPortfolio();

      // assert
      expect(result, isA<PortfolioEntity>());
      expect(result.balance.netValue, 1000.0);
      expect(result.balance.pnl, 100.0);
      expect(result.balance.pnlPercentage, 10.0);
      expect(result.positions.length, 1);
      expect(result.positions.first.instrument.ticker, 'AAPL');
    });

    test('should propagate error from remote data source', () async {
      // arrange
      const errorMessage = 'Network error';
      mockDataSource.setException(Exception(errorMessage));

      // act & assert
      expect(
        () => repository.fetchPortfolio(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
