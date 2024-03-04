import 'package:flutter/material.dart';
import 'package:npstock/api/ticker_api.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/model/all_tickers_model.dart';
import 'package:npstock/model/watch_list_model.dart';

class TickerController extends ChangeNotifier {
  ApiResponse<AllTickersModel> allTicker = ApiResponse.loading();
  ApiResponse<WatchListModel> userTicker = ApiResponse.loading();
  TickerApi tickerApi = TickerApi();
  List<String> allUserTicker = [];

  bool showDelete = false;

  setShowDelete({bool? value}) {
    if (userTicker.data != null) {
      if (userTicker.data!.response.isNotEmpty) {
        showDelete = value ?? !showDelete;
        notifyListeners();
      }
    }
  }

  deleteUserTicker(int index) {
    List<ResponseDataWL> userTickerTemp = [...userTicker.data!.response];
    userTickerTemp.removeAt(index);
    DatabaseHelperRepository().deleteTicker(index);
    if (userTickerTemp.isEmpty) {
      showDelete = false;
    }
    setStateWatchList(
        ApiResponse.completed(WatchListModel(response: userTickerTemp)));
  }

  setStateWatchList(ApiResponse<WatchListModel> value,
      {bool noNotifier = false}) {
    userTicker = value;
    if (!noNotifier) notifyListeners();
  }

  setStateAllTicker(ApiResponse<AllTickersModel> value,
      {bool noNotifier = false}) {
    allTicker = value;
    if (!noNotifier) notifyListeners();
  }

  Future<void> getAllTicker() async {
    // allTicker = ApiResponse.loading();
    await tickerApi.getAllTicker().then((value) {
      setStateAllTicker(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setStateAllTicker(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getUserTicker({bool userNotifier = false}) async {
    if (userNotifier) {
      userTicker = ApiResponse.loading();
    }
    dynamic allTickerDb = await DatabaseHelperRepository().getAllTicker();
    if (allTickerDb != null) {
      allUserTicker = allTickerDb;
      await tickerApi.getUserTicker(allTickerDb).then((value) {
        setStateWatchList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setStateWatchList(ApiResponse.error(error.toString()));
      });
    } else {
      setStateWatchList(ApiResponse.completed(WatchListModel(response: [])));
    }
  }
}
