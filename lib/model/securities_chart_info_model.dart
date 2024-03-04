// To parse this JSON data, do
//
//     final securitiesChartInfo = securitiesChartInfoFromJson(jsonString);

import 'dart:convert';

SecuritiesChartInfoModel securitiesChartInfoFromJson(String str) =>
    SecuritiesChartInfoModel.fromJson(json.decode(str));

String securitiesChartInfoToJson(SecuritiesChartInfoModel data) =>
    json.encode(data.toJson());

class SecuritiesChartInfoModel {
  final Response response;

  SecuritiesChartInfoModel({
    required this.response,
  });

  factory SecuritiesChartInfoModel.fromJson(Map<String, dynamic> json) =>
      SecuritiesChartInfoModel(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  final String ticker;
  final double percentageChange;
  final List<ChartDatum> chartData;

  Response({
    required this.ticker,
    required this.percentageChange,
    required this.chartData,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        ticker: json["ticker"],
        percentageChange: json["percentageChange"]?.toDouble(),
        chartData: List<ChartDatum>.from(
            json["chartData"].map((x) => ChartDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "percentageChange": percentageChange,
        "chartData": List<dynamic>.from(chartData.map((x) => x.toJson())),
      };
}

class ChartDatum {
  final double value;
  final DateTime timestamp;

  ChartDatum({
    required this.value,
    required this.timestamp,
  });

  factory ChartDatum.fromJson(Map<String, dynamic> json) => ChartDatum(
        value: json["value"]?.toDouble(),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "timestamp": timestamp.toIso8601String(),
      };
}
