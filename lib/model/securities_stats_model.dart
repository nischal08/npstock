// To parse this JSON data, do
//
//     final securitiesStats = securitiesStatsFromJson(jsonString);

import 'dart:convert';

SecuritiesStatsModel securitiesStatsFromJson(String str) =>
    SecuritiesStatsModel.fromJson(json.decode(str));

String securitiesStatsToJson(SecuritiesStatsModel data) =>
    json.encode(data.toJson());

class SecuritiesStatsModel {
  final ResponseSSM response;

  SecuritiesStatsModel({
    required this.response,
  });

  factory SecuritiesStatsModel.fromJson(Map<String, dynamic> json) =>
      SecuritiesStatsModel(
        response: ResponseSSM.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class ResponseSSM {
  final String ticker;
  final double ltp;
  final double pointChange;
  final double percentageChange;
  final int volume;
  final int sharesTraded;
  final int marketCap;
  final String updatedOn;

  ResponseSSM({
    required this.ticker,
    required this.ltp,
    required this.pointChange,
    required this.percentageChange,
    required this.volume,
    required this.sharesTraded,
    required this.marketCap,
    required this.updatedOn,
  });

  factory ResponseSSM.fromJson(Map<String, dynamic> json) => ResponseSSM(
        ticker: json["ticker"],
        ltp: json["ltp"]?.toDouble(),
        pointChange: json["point_change"] == null
            ? 0.0
            : json["point_change"]!.toDouble(),
        percentageChange: json["percentage_change"] == null
            ? 0.0
            : json["percentage_change"]!.toDouble(),
        volume: json["volume"]??0,
        sharesTraded: json["shares_traded"],
        marketCap: json["market_cap"]??0,
        updatedOn: json["updated_on"] ?? "",
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
