import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:npstock/api/detail_api.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/model/market_range_model.dart';
import 'package:npstock/model/securities_chart_info_model.dart';
import 'package:npstock/model/securities_stats_model.dart';

class DetailController extends ChangeNotifier {
  DetailApi detailApi = DetailApi();
  List durationNames = [
    "1d",
    "1m",
    "3m",
    "1y",
    "5y",
    "all",
  ];

  String currentDuration = "1d";

  setCurrentDuration(String durationName) {
    currentDuration = durationName;
    notifyListeners();
  }

  Map<String, ApiResponse<SecuritiesStatsModel>> allStats = {};
  Map<String, ApiResponse<MarketRangeModel>> allMarketRange = {};
  Map<String, Map<String, ApiResponse<SecuritiesChartInfoModel>>> allChartInfo =
      {};
  getAllStats({bool userNotifier = true}) async {
    dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
    if (allTickerDb != null) {
      for (String ticker in allTickerDb) {
        allChartInfo[ticker] = {};
        allStats[ticker] = ApiResponse.loading();
        if (userNotifier) notifyListeners();
        allMarketRange[ticker] = ApiResponse.loading();
        if (userNotifier) notifyListeners();
        for (String name in durationNames) {
          allChartInfo[ticker]![name] = ApiResponse.loading();
          if (userNotifier) notifyListeners();
        }
      }
      log(allChartInfo.toString());
      log(allStats.toString());
      for (String ticker in allTickerDb) {
        detailApi.getSecuritiesStatsDetail(ticker).then((value) {
          allStats[ticker] = ApiResponse.completed(value);

          notifyListeners();
        }).onError((e, s) {
          log(s.toString());
          log(e.toString());
          allStats[ticker] = ApiResponse.error(e.toString());
          notifyListeners();
        });
        detailApi.getMarketRange(ticker).then((value) {
          allMarketRange[ticker] = ApiResponse.completed(value);
          notifyListeners();
        }).onError((e, s) {
          log(s.toString());
          log(e.toString());
          allMarketRange[ticker] = ApiResponse.error(e.toString());
          notifyListeners();
        });

        for (String durationName in durationNames) {
          detailApi
              .getSecuritiesChartInfo(ticker, duration: durationName)
              .then((value) {
            allChartInfo[ticker]![durationName] = ApiResponse.completed(value);
            notifyListeners();
          }).onError((e, s) {
            log(s.toString());
            log(e.toString());
            allChartInfo[ticker] = {};
            allChartInfo[ticker]![durationName] =
                ApiResponse.error(e.toString());
            notifyListeners();
          });
        }
      }
    }
  }

  getAllOneDayChartData() async {
    dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
    if (allTickerDb != null) {
      for (String ticker in allTickerDb) {
        allChartInfo[ticker]!["1d"] =
            ApiResponse.loading(allChartInfo[ticker]!["1d"]!.data!);
        notifyListeners();
        detailApi.getSecuritiesChartInfo(ticker, duration: "1d").then((value) {
          allChartInfo[ticker]!["1d"] = ApiResponse.completed(value);
          notifyListeners();
        }).onError((e, s) {
          log(s.toString());
          log(e.toString());
          allChartInfo[ticker] = {};
          allChartInfo[ticker]!["1d"] = ApiResponse.error(e.toString());
          notifyListeners();
        });
      }
    }
  }
}
