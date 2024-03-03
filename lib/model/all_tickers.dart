import 'dart:convert';

AllTickers allTickersFromJson(String str) =>
    AllTickers.fromJson(json.decode(str));

String allTickersToJson(AllTickers data) => json.encode(data.toJson());

class AllTickers {
  final List<ResponseData> response;

  AllTickers({
    required this.response,
  });

  factory AllTickers.fromJson(Map<String, dynamic> json) => AllTickers(
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
