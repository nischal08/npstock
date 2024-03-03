// To parse this JSON data, do
//
//     final allTickets = allTicketsFromJson(jsonString);

import 'dart:convert';

AllTickets allTicketsFromJson(String str) =>
    AllTickets.fromJson(json.decode(str));

String allTicketsToJson(AllTickets data) => json.encode(data.toJson());

class AllTickets {
  final List<ResponseData> response;

  AllTickets({
    required this.response,
  });

  factory AllTickets.fromJson(Map<String, dynamic> json) => AllTickets(
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

enum Sector {
  BANKING,
  BOND,
  DEVELOPMENT_BANK,
  FINANCE,
  HOTELS_AND_TOURISM,
  HYDRO_POWER,
  INVESTMENT,
  LIFE_INSURANCE,
  MANU_PRO,
  MICROFINANCE,
  MUTUAL_FUND,
  NON_LIFE_INSURANCE,
  OTHERS,
  TRADING
}

final sectorValues = EnumValues({
  "Banking": Sector.BANKING,
  "Bond": Sector.BOND,
  "Development Bank": Sector.DEVELOPMENT_BANK,
  "Finance": Sector.FINANCE,
  "Hotels And Tourism": Sector.HOTELS_AND_TOURISM,
  "HydroPower": Sector.HYDRO_POWER,
  "Investment": Sector.INVESTMENT,
  "Life Insurance": Sector.LIFE_INSURANCE,
  "Manu.& Pro.": Sector.MANU_PRO,
  "Microfinance": Sector.MICROFINANCE,
  "Mutual Fund": Sector.MUTUAL_FUND,
  "Non Life Insurance": Sector.NON_LIFE_INSURANCE,
  "Others": Sector.OTHERS,
  "Trading": Sector.TRADING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
