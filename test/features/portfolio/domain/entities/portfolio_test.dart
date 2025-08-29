import 'package:baraka/src/features/portfolio/domain/entities/portfolio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PortfolioEntity', () {
    test('should create portfolio with balance and positions', () {
      final balance = BalanceEntity(
        netValue: 1000.0,
        pnl: 100.0,
        pnlPercentage: 10.0,
      );

      final instrument = InstrumentEntity(
        ticker: 'AAPL',
        name: 'Apple Inc.',
        exchange: 'NASDAQ',
        currency: 'USD',
        lastTradedPrice: 150.0,
      );

      final position = PositionEntity(
        instrument: instrument,
        quantity: 10.0,
        averagePrice: 100.0,
        cost: 1000.0,
        marketValue: 1500.0,
        pnl: 500.0,
        pnlPercentage: 50.0,
      );

      final portfolio = PortfolioEntity(
        balance: balance,
        positions: [position],
      );

      expect(portfolio.balance, balance);
      expect(portfolio.positions, [position]);
      expect(portfolio.positions.length, 1);
    });
  });

  group('BalanceEntity', () {
    test('should create balance with correct values', () {
      final balance = BalanceEntity(
        netValue: 1000.0,
        pnl: 100.0,
        pnlPercentage: 10.0,
      );

      expect(balance.netValue, 1000.0);
      expect(balance.pnl, 100.0);
      expect(balance.pnlPercentage, 10.0);
    });
  });

  group('PositionEntity', () {
    test('should create position with correct values', () {
      final instrument = InstrumentEntity(
        ticker: 'GOOGL',
        name: 'Alphabet Inc.',
        exchange: 'NASDAQ',
        currency: 'USD',
        lastTradedPrice: 200.0,
      );

      final position = PositionEntity(
        instrument: instrument,
        quantity: 5.0,
        averagePrice: 180.0,
        cost: 900.0,
        marketValue: 1000.0,
        pnl: 100.0,
        pnlPercentage: 11.11,
      );

      expect(position.instrument, instrument);
      expect(position.quantity, 5.0);
      expect(position.averagePrice, 180.0);
      expect(position.cost, 900.0);
      expect(position.marketValue, 1000.0);
      expect(position.pnl, 100.0);
      expect(position.pnlPercentage, 11.11);
    });
  });

  group('InstrumentEntity', () {
    test('should create instrument with correct values', () {
      final instrument = InstrumentEntity(
        ticker: 'MSFT',
        name: 'Microsoft Corporation',
        exchange: 'NASDAQ',
        currency: 'USD',
        lastTradedPrice: 300.0,
      );

      expect(instrument.ticker, 'MSFT');
      expect(instrument.name, 'Microsoft Corporation');
      expect(instrument.exchange, 'NASDAQ');
      expect(instrument.currency, 'USD');
      expect(instrument.lastTradedPrice, 300.0);
    });
  });
}
