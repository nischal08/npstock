import 'dart:convert';

AllTickersModel allTickersFromJson(String str) =>
    AllTickersModel.fromJson(json.decode(str));

String allTickersToJson(AllTickersModel data) => json.encode(data.toJson());

class AllTickersModel {
  final List<ResponseData> response;

  AllTickersModel({
    required this.response,
  });

  factory AllTickersModel.fromJson(Map<String, dynamic> json) => AllTickersModel(
        response: List<ResponseData>.from(
            json["response"].map((x) => ResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ResponseData {
  final String ticker;
  final String? tickerName;
  final String icon;
  // final Sector? sector;
  final double pointChange;
  final double percentageChange;

  ResponseData({
    required this.ticker,
    required this.tickerName,
    required this.icon,
    // required this.sector,
    required this.pointChange,
    required this.percentageChange,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        ticker: json["ticker"],
        tickerName: json["ticker_name"],
        icon: json["icon"],
        // sector: sectorValues.map[json["sector"]]!,
        pointChange: json["point_change"]?.toDouble(),
        percentageChange: json["percentage_change"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "ticker_name": tickerName,
        "icon": icon,
        // "sector": sectorValues.reverse[sector],
        "point_change": pointChange,
        "percentage_change": percentageChange,
      };
}
