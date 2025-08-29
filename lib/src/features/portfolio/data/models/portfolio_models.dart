import '../../domain/entities/portfolio.dart';

class PortfolioDto {
  final BalanceDto balance;
  final List<PositionDto> positions;

  const PortfolioDto({
    required this.balance,
    required this.positions,
  });

  factory PortfolioDto.fromJson(Map<String, dynamic> json) {
    final portfolioJson =
        (json['portfolio'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{};
    final balanceJson =
        (portfolioJson['balance'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{};
    final positionsJson = (portfolioJson['positions'] as List?) ?? const [];
    return PortfolioDto(
      balance: BalanceDto.fromJson(balanceJson),
      positions: positionsJson
          .whereType<Map>()
          .map((e) => PositionDto.fromJson(e.cast<String, dynamic>()))
          .toList(),
    );
  }

  PortfolioEntity toEntity() => PortfolioEntity(
        balance: balance.toEntity(),
        positions: positions.map((e) => e.toEntity()).toList(),
      );
}

class BalanceDto {
  final double netValue;
  final double pnl;
  final double pnlPercentage;

  const BalanceDto({
    required this.netValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory BalanceDto.fromJson(Map<String, dynamic> json) => BalanceDto(
        netValue: (json['netValue'] as num?)?.toDouble() ?? 0,
        pnl: (json['pnl'] as num?)?.toDouble() ?? 0,
        pnlPercentage: (json['pnlPercentage'] as num?)?.toDouble() ?? 0,
      );

  BalanceEntity toEntity() => BalanceEntity(
        netValue: netValue,
        pnl: pnl,
        pnlPercentage: pnlPercentage,
      );
}

class PositionDto {
  final InstrumentDto instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double pnl;
  final double pnlPercentage;

  const PositionDto({
    required this.instrument,
    required this.quantity,
    required this.averagePrice,
    required this.cost,
    required this.marketValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory PositionDto.fromJson(Map<String, dynamic> json) {
    return PositionDto(
      instrument:
          InstrumentDto.fromJson(json['instrument'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
      averagePrice: (json['averagePrice'] as num?)?.toDouble() ?? 0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      marketValue: (json['marketValue'] as num?)?.toDouble() ?? 0,
      pnl: (json['pnl'] as num?)?.toDouble() ?? 0,
      pnlPercentage: (json['pnlPercentage'] as num?)?.toDouble() ?? 0,
    );
  }

  PositionEntity toEntity() => PositionEntity(
        instrument: instrument.toEntity(),
        quantity: quantity,
        averagePrice: averagePrice,
        cost: cost,
        marketValue: marketValue,
        pnl: pnl,
        pnlPercentage: pnlPercentage,
      );
}

class InstrumentDto {
  final String ticker;
  final String name;
  final String exchange;
  final String currency;
  final double lastTradedPrice;

  const InstrumentDto({
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.lastTradedPrice,
  });

  factory InstrumentDto.fromJson(Map<String, dynamic> json) => InstrumentDto(
        ticker: json['ticker'] as String? ?? '',
        name: json['name'] as String? ?? '',
        exchange: json['exchange'] as String? ?? '',
        currency: json['currency'] as String? ?? 'USD',
        lastTradedPrice: (json['lastTradedPrice'] as num?)?.toDouble() ?? 0,
      );

  InstrumentEntity toEntity() => InstrumentEntity(
        ticker: ticker,
        name: name,
        exchange: exchange,
        currency: currency,
        lastTradedPrice: lastTradedPrice,
      );
}
