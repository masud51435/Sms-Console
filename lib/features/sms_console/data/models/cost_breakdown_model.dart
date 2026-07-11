import '../../domain/entities/cost_breakdown_entity.dart';

class CostBreakdownModel {
  final String currency;
  final String totalCost;
  final List<CostRowModel> rows;

  CostBreakdownModel({
    required this.currency,
    required this.totalCost,
    required this.rows,
  });

  factory CostBreakdownModel.fromJson(Map<String, dynamic> json) {
    return CostBreakdownModel(
      currency: json['currency'] as String,
      totalCost: json['totalCost'] as String,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => CostRowModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  CostBreakdownEntity toEntity() {
    return CostBreakdownEntity(
      currency: currency,
      totalCost: totalCost,
      rows: rows.map((e) => e.toEntity()).toList(),
    );
  }
}

class CostRowModel {
  final String provider;
  final String totalCost;
  final int messageCount;

  CostRowModel({
    required this.provider,
    required this.totalCost,
    required this.messageCount,
  });

  factory CostRowModel.fromJson(Map<String, dynamic> json) {
    return CostRowModel(
      provider: json['provider'] as String,
      totalCost: json['totalCost'] as String,
      messageCount: json['messageCount'] as int,
    );
  }

  CostRowEntity toEntity() {
    return CostRowEntity(
      provider: provider,
      totalCost: totalCost,
      messageCount: messageCount,
    );
  }
}
