// To parse this JSON data, do
//
//     final watchList = watchListFromJson(jsonString);

import 'dart:convert';

WatchList watchListFromJson(String str) => WatchList.fromJson(json.decode(str));

String watchListToJson(WatchList data) => json.encode(data.toJson());

class WatchList {
  final List<ResponseData> response;

  WatchList({
    required this.response,
  });

  factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
        response: List<ResponseData>.from(
            json["response"].map((x) => ResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ResponseData {
  final String ticker;
  final String indices;
  final String tickerName;
  final double ltp;
  final int ltv;
  final double pointChange;
  final double percentageChange;
  final int open;
  final double high;
  final int low;
  final int volume;
  final double previousClosing;
  final DateTime calculatedOn;
  final double amount;
  final String datasource;
  final String icon;
  final List<ChartDatum> chartData;

  ResponseData({
    required this.ticker,
    required this.indices,
    required this.tickerName,
    required this.ltp,
    required this.ltv,
    required this.pointChange,
    required this.percentageChange,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.previousClosing,
    required this.calculatedOn,
    required this.amount,
    required this.datasource,
    required this.icon,
    required this.chartData,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        ticker: json["ticker"],
        indices: json["indices"],
        tickerName: json["ticker_name"],
        ltp: json["ltp"]?.toDouble(),
        ltv: json["ltv"],
        pointChange: json["point_change"]?.toDouble(),
        percentageChange: json["percentage_change"]?.toDouble(),
        open: json["open"],
        high: json["high"]?.toDouble(),
        low: json["low"],
        volume: json["volume"],
        previousClosing: json["previousClosing"]?.toDouble(),
        calculatedOn: DateTime.parse(json["calculated_on"]),
        amount: json["amount"]?.toDouble(),
        datasource: json["datasource"],
        icon: json["icon"],
        chartData: List<ChartDatum>.from(
            json["chartData"].map((x) => ChartDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "indices": indices,
        "ticker_name": tickerName,
        "ltp": ltp,
        "ltv": ltv,
        "point_change": pointChange,
        "percentage_change": percentageChange,
        "open": open,
        "high": high,
        "low": low,
        "volume": volume,
        "previousClosing": previousClosing,
        "calculated_on": calculatedOn.toIso8601String(),
        "amount": amount,
        "datasource": datasource,
        "icon": icon,
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
