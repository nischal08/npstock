import 'dart:developer';

import 'package:npstock/api/api_manager.dart';
import 'package:npstock/data/app_urls.dart';
import 'package:npstock/data/enum/request_type.dart';
import 'package:npstock/model/all_tickets.dart';
import 'package:npstock/model/watch_list_model.dart';

class TicketApi {
  final _apiManager = ApiManager();
  Future<AllTickets> getAllTicket() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.allTicket,
        requestType: RequestType.get,
      );
      return AllTickets.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<WatchList> getUserTicket(List ticket) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.watchList,
        requestType: RequestType.post,
      );
      return WatchList.fromJson(response);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
