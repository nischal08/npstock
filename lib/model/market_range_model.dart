import 'dart:convert';

MarketRangeModel marketRangeModelFromJson(String str) =>
    MarketRangeModel.fromJson(json.decode(str));

String marketRangeModelToJson(MarketRangeModel data) =>
    json.encode(data.toJson());

class MarketRangeModel {
  final Response response;

  MarketRangeModel({
    required this.response,
  });

  factory MarketRangeModel.fromJson(Map<String, dynamic> json) =>
      MarketRangeModel(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  final double high24H;
  final double low24H;
  final double percentile24H;

  Response({
    required this.high24H,
    required this.low24H,
    required this.percentile24H,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        high24H: json["high_24h"] == null ? 0 : json["high_24h"].toDouble(),
        low24H: json["low_24h"] == null ? 0 : json["low_24h"].toDouble(),
        percentile24H: json["percentile_24h"] == null
            ? 0.0
            : json["percentile_24h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "high_24h": high24H,
        "low_24h": low24H,
        "percentile_24h": percentile24H,
      };
}
