import 'dart:developer';
import 'package:npstock/api/api_manager.dart';
import 'package:npstock/data/app_urls.dart';
import 'package:npstock/data/enum/request_type.dart';
import 'package:npstock/model/all_tickers_model.dart';
import 'package:npstock/model/watch_list_model.dart';

class TickerApi {
  final _apiManager = ApiManager();
  Future<AllTickersModel> getAllTicker() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.allTicker,
        requestType: RequestType.get,
      );
      return AllTickersModel.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<WatchListModel> getUserTicker(List tickers) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.watchList,
          requestType: RequestType.post,
          parameter: {"tickerList": tickers});
      return WatchListModel.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
