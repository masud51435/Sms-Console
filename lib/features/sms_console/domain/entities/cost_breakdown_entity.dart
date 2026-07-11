class CostBreakdownEntity {
  final String currency;
  final String totalCost;
  final List<CostRowEntity> rows;

  CostBreakdownEntity({
    required this.currency,
    required this.totalCost,
    required this.rows,
  });
}

class CostRowEntity {
  final String provider;
  final String totalCost;
  final int messageCount;

  CostRowEntity({
    required this.provider,
    required this.totalCost,
    required this.messageCount,
  });
}
