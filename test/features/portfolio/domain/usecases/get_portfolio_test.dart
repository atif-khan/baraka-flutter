import 'package:baraka/src/features/portfolio/domain/entities/portfolio.dart';
import 'package:baraka/src/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka/src/features/portfolio/domain/usecases/get_portfolio.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPortfolioRepository implements PortfolioRepository {
  PortfolioEntity? _returnValue;
  Exception? _throwException;

  void setReturnValue(PortfolioEntity value) {
    _returnValue = value;
    _throwException = null;
  }

  void setException(Exception exception) {
    _throwException = exception;
    _returnValue = null;
  }

  @override
  Future<PortfolioEntity> fetchPortfolio() async {
    if (_throwException != null) {
      throw _throwException!;
    }
    return _returnValue!;
  }
}

void main() {
  late GetPortfolioUseCase useCase;
  late MockPortfolioRepository mockRepository;

  setUp(() {
    mockRepository = MockPortfolioRepository();
    useCase = GetPortfolioUseCase(mockRepository);
  });

  group('GetPortfolioUseCase', () {
    test('should get portfolio from repository', () async {
      // arrange
      final expectedPortfolio = PortfolioEntity(
        balance: BalanceEntity(
          netValue: 1000.0,
          pnl: 100.0,
          pnlPercentage: 10.0,
        ),
        positions: [
          PositionEntity(
            instrument: InstrumentEntity(
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

      mockRepository.setReturnValue(expectedPortfolio);

      // act
      final result = await useCase();

      // assert
      expect(result, expectedPortfolio);
    });

    test('should propagate error from repository', () async {
      // arrange
      const errorMessage = 'Network error';
      mockRepository.setException(Exception(errorMessage));

      // act & assert
      expect(
        () => useCase(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
