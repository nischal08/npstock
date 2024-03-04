import 'dart:developer';
import 'package:npstock/api/api_manager.dart';
import 'package:npstock/data/app_urls.dart';
import 'package:npstock/data/enum/request_type.dart';
import 'package:npstock/model/securities_chart_info_model.dart';
import 'package:npstock/model/securities_stats_model.dart';

class DetailApi {
  final _apiManager = ApiManager();

  Future<SecuritiesStatsModel> getSecuritiesStatsDetail(String value) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.securitiesStats.replaceAll("[name]", value),
        requestType: RequestType.get,
      );
      return SecuritiesStatsModel.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<SecuritiesChartInfoModel> getSecuritiesChartInfo(String value,{required String duration}) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.chartDataByTimeType.replaceAll("[name]", value).replaceAll("[duration]", duration),
        requestType: RequestType.get,
      );
      return SecuritiesChartInfoModel.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
