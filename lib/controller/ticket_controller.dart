import 'package:flutter/material.dart';
import 'package:npstock/api/ticket_api.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/model/all_tickets.dart';
import 'package:npstock/model/watch_list_model.dart';

class TicketController extends ChangeNotifier {
  ApiResponse<AllTickets> allTicket = ApiResponse.loading();
  ApiResponse<WatchList> userTicket = ApiResponse.loading();
  TicketApi ticketApi = TicketApi();
  Future<void> getAllTicket() async {
    // allTicket = ApiResponse.loading();
    await ticketApi.getAllTicket().then((value) {
      allTicket = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      allTicket = ApiResponse.error(error.toString());
      notifyListeners();
    });
  }

  Future<void> getUserTicket() async {
    // userTicket = ApiResponse.loading();
    List<String>? allTicketDb = await DatabaseHelperRepository().getAllTicket();
    if (allTicketDb != null) {
      await ticketApi.getUserTicket(allTicketDb).then((value) {
        userTicket = ApiResponse.completed(value);
        notifyListeners();
      }).onError((error, stackTrace) {
        userTicket = ApiResponse.error(error.toString());
        notifyListeners();
      });
    } else {
      userTicket = ApiResponse.completed(WatchList(response: []));
      notifyListeners();
    }
  }
}
