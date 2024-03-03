import 'package:flutter/material.dart';
import 'package:npstock/api/ticker_api.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/model/all_tickers.dart';
import 'package:npstock/model/watch_list_model.dart';

class TickerController extends ChangeNotifier {
  ApiResponse<AllTickers> allTicker = ApiResponse.loading();
  ApiResponse<WatchList> userTicker = ApiResponse.loading();
  TickerApi tickerApi = TickerApi();
  List<String> allUserTicker = [];
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

  Future<void> getAllTicker() async {
    // allTicker = ApiResponse.loading();
    await TickerApi().getAllTicker().then((value) {
      allTicker = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      allTicker = ApiResponse.error(error.toString());
      notifyListeners();
    });
  }

  Future<void> getUserTicker({bool userNotifier = false}) async {
    if (userNotifier) {
      userTicker = ApiResponse.loading();
    }
    dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
    if (allTickerDb != null) {
      allUserTicker = allTickerDb;
      await TickerApi().getUserTicker(allTickerDb).then((value) {
        userTicker = ApiResponse.completed(value);
        notifyListeners();
      }).onError((error, stackTrace) {
        userTicker = ApiResponse.error(error.toString());
        notifyListeners();
      });
    } else {
      userTicker = ApiResponse.completed(WatchList(response: []));
      notifyListeners();
    }
  }
}
