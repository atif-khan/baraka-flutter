import 'package:baraka/src/features/portfolio/data/models/portfolio_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PortfolioDto', () {
    test('should create from JSON and convert to entity', () {
      final json = {
        'portfolio': {
          'balance': {
            'netValue': 1000.0,
            'pnl': 100.0,
            'pnlPercentage': 10.0,
          },
          'positions': [
            {
              'instrument': {
                'ticker': 'AAPL',
                'name': 'Apple Inc.',
                'exchange': 'NASDAQ',
                'currency': 'USD',
                'lastTradedPrice': 150.0,
              },
              'quantity': 10.0,
              'averagePrice': 100.0,
              'cost': 1000.0,
              'marketValue': 1500.0,
              'pnl': 500.0,
              'pnlPercentage': 50.0,
            }
          ]
        },
      };

      final dto = PortfolioDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.balance.netValue, 1000.0);
      expect(entity.balance.pnl, 100.0);
      expect(entity.balance.pnlPercentage, 10.0);
      expect(entity.positions.length, 1);
      expect(entity.positions.first.instrument.ticker, 'AAPL');
    });

    test('should handle missing fields with defaults', () {
      final json = <String, dynamic>{};

      final dto = PortfolioDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.balance.netValue, 0.0);
      expect(entity.balance.pnl, 0.0);
      expect(entity.balance.pnlPercentage, 0.0);
      expect(entity.positions, isEmpty);
    });
  });

  group('BalanceDto', () {
    test('should create from JSON and convert to entity', () {
      final json = {
        'netValue': 2000.0,
        'pnl': 200.0,
        'pnlPercentage': 20.0,
      };

      final dto = BalanceDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.netValue, 2000.0);
      expect(entity.pnl, 200.0);
      expect(entity.pnlPercentage, 20.0);
    });

    test('should handle missing fields with defaults', () {
      final json = <String, dynamic>{};

      final dto = BalanceDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.netValue, 0.0);
      expect(entity.pnl, 0.0);
      expect(entity.pnlPercentage, 0.0);
    });
  });

  group('PositionDto', () {
    test('should create from JSON and convert to entity', () {
      final json = {
        'instrument': {
          'ticker': 'GOOGL',
          'name': 'Alphabet Inc.',
          'exchange': 'NASDAQ',
          'currency': 'USD',
          'lastTradedPrice': 200.0,
        },
        'quantity': 5.0,
        'averagePrice': 180.0,
        'cost': 900.0,
        'marketValue': 1000.0,
        'pnl': 100.0,
        'pnlPercentage': 11.11,
      };

      final dto = PositionDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.instrument.ticker, 'GOOGL');
      expect(entity.instrument.name, 'Alphabet Inc.');
      expect(entity.quantity, 5.0);
      expect(entity.averagePrice, 180.0);
      expect(entity.cost, 900.0);
      expect(entity.marketValue, 1000.0);
      expect(entity.pnl, 100.0);
      expect(entity.pnlPercentage, 11.11);
    });

    test('should handle missing fields with defaults', () {
      final json = <String, dynamic>{
        'instrument': <String, dynamic>{},
      };

      final dto = PositionDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.instrument.ticker, '');
      expect(entity.instrument.name, '');
      expect(entity.instrument.exchange, '');
      expect(entity.instrument.currency, 'USD');
      expect(entity.instrument.lastTradedPrice, 0.0);
      expect(entity.quantity, 0.0);
      expect(entity.averagePrice, 0.0);
      expect(entity.cost, 0.0);
      expect(entity.marketValue, 0.0);
      expect(entity.pnl, 0.0);
      expect(entity.pnlPercentage, 0.0);
    });
  });

  group('InstrumentDto', () {
    test('should create from JSON and convert to entity', () {
      final json = {
        'ticker': 'MSFT',
        'name': 'Microsoft Corporation',
        'exchange': 'NASDAQ',
        'currency': 'USD',
        'lastTradedPrice': 300.0,
      };

      final dto = InstrumentDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.ticker, 'MSFT');
      expect(entity.name, 'Microsoft Corporation');
      expect(entity.exchange, 'NASDAQ');
      expect(entity.currency, 'USD');
      expect(entity.lastTradedPrice, 300.0);
    });

    test('should handle missing fields with defaults', () {
      final json = <String, dynamic>{};

      final dto = InstrumentDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.ticker, '');
      expect(entity.name, '');
      expect(entity.exchange, '');
      expect(entity.currency, 'USD');
      expect(entity.lastTradedPrice, 0.0);
    });
  });
}
