class PortfolioEntity {
  final BalanceEntity balance;
  final List<PositionEntity> positions;

  const PortfolioEntity({
    required this.balance,
    required this.positions,
  });
}

class BalanceEntity {
  final double netValue;
  final double pnl;
  final double pnlPercentage;

  const BalanceEntity({
    required this.netValue,
    required this.pnl,
    required this.pnlPercentage,
  });
}

class PositionEntity {
  final InstrumentEntity instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double pnl;
  final double pnlPercentage;

  const PositionEntity({
    required this.instrument,
    required this.quantity,
    required this.averagePrice,
    required this.cost,
    required this.marketValue,
    required this.pnl,
    required this.pnlPercentage,
  });
}

class InstrumentEntity {
  final String ticker;
  final String name;
  final String exchange;
  final String currency;
  final double lastTradedPrice;

  const InstrumentEntity({
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.lastTradedPrice,
  });
}
