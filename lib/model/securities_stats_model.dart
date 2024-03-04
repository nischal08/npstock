// To parse this JSON data, do
//
//     final securitiesStats = securitiesStatsFromJson(jsonString);

import 'dart:convert';

SecuritiesStatsModel securitiesStatsFromJson(String str) =>
    SecuritiesStatsModel.fromJson(json.decode(str));

String securitiesStatsToJson(SecuritiesStatsModel data) =>
    json.encode(data.toJson());

class SecuritiesStatsModel {
  final Response response;

  SecuritiesStatsModel({
    required this.response,
  });

  factory SecuritiesStatsModel.fromJson(Map<String, dynamic> json) =>
      SecuritiesStatsModel(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  final String ticker;
  final double ltp;
  final int pointChange;
  final int percentageChange;
  final double volume;
  final int sharesTraded;
  final int marketCap;
  final String updatedOn;

  Response({
    required this.ticker,
    required this.ltp,
    required this.pointChange,
    required this.percentageChange,
    required this.volume,
    required this.sharesTraded,
    required this.marketCap,
    required this.updatedOn,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        ticker: json["ticker"],
        ltp: json["ltp"]?.toDouble(),
        pointChange: json["point_change"],
        percentageChange: json["percentage_change"],
        volume: json["volume"]?.toDouble(),
        sharesTraded: json["shares_traded"],
        marketCap: json["market_cap"],
        updatedOn: json["updated_on"],
      );

  Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "ltp": ltp,
        "point_change": pointChange,
        "percentage_change": percentageChange,
        "volume": volume,
        "shares_traded": sharesTraded,
        "market_cap": marketCap,
        "updated_on": updatedOn,
      };
}
