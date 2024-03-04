import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:npstock/api/detail_api.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/model/securities_chart_info_model.dart';
import 'package:npstock/model/securities_stats_model.dart';

class DetailController extends ChangeNotifier {
  DetailApi detailApi = DetailApi();
  List durationNames = [
    "1D",
    "1M",
    "3M",
    "1Y",
    "5Y",
    "All",
  ];

  String currentDuration = "1D";

  setCurrentDuration(String durationName) {
    currentDuration = durationName;
    notifyListeners();
  }

  Map<String, ApiResponse<SecuritiesStatsModel>> allStats = {};
  Map<String, ApiResponse<SecuritiesChartInfoModel>> allChartInfo = {};
  getAllStats({bool userNotifier = true}) async {
    dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
    if (allTickerDb != null) {
      for (String ticker in allTickerDb) {
        if (userNotifier) {
          allStats[ticker] = ApiResponse.loading();
          if (userNotifier) notifyListeners();
        }
      }
      log(allStats.toString());
      for (String ticker in allTickerDb) {
        await detailApi.getSecuritiesStatsDetail(ticker).then((value) {
          allStats[ticker] = ApiResponse.completed(value);

          notifyListeners();
        }).onError((e, s) {
          log(s.toString());
          log(e.toString());
          allStats[ticker] = ApiResponse.error(e.toString());
          notifyListeners();
        });
        await detailApi
            .getSecuritiesChartInfo(ticker, duration: "1d")
            .then((value) {
          allChartInfo[ticker] = ApiResponse.completed(value);
          notifyListeners();
        }).onError((e, s) {
          log(s.toString());
          log(e.toString());
          allChartInfo[ticker] = ApiResponse.error(e.toString());
          notifyListeners();
        });
      }
    }
  }

  // getChartInfo({bool userNotifier = true}) async {
  //   dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
  //   if (allTickerDb != null) {
  //     for (String ticker in allTickerDb) {
  //       if (userNotifier) {
  //         allChartInfo[ticker] = ApiResponse.loading();
  //         if (userNotifier) notifyListeners();
  //       }
  //     }
  //     log(allChartInfo.toString());
  //     for (String ticker in allTickerDb) {
  //       await detailApi.getSecuritiesChartInfo(ticker).then((value) {
  //         allChartInfo[ticker] = ApiResponse.completed(value);
  //         notifyListeners();
  //       }).onError((e, s) {
  //         log(s.toString());
  //         log(e.toString());
  //         allChartInfo[ticker] = ApiResponse.error(e.toString());
  //         notifyListeners();
  //       });
  //     }
  //   }
  // }
}
