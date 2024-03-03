import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:npstock/controller/ticket_controller.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TicketSelectScreen extends StatelessWidget {
  TicketSelectScreen({super.key});
  String currentName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select ticket"),
      ),
      body: Consumer<TicketController>(builder: (context, provider, __) {
        switch (provider.allTicket.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case Status.ERROR:
            return const Center(child: Text("Error"));

          case Status.COMPLETED:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Select Ticket:",
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        width: 16,
                      ),
                      CustomDropdown(
                        items: provider.allTicket.data!.response
                            .map((e) => e.tickerName ?? "N?A")
                            .toList(),
                        onChanged: (String newValue) {
                          currentName = newValue;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      debugger();
                      String tickerName = provider
                          .allTicket
                          .data!
                          .response[provider.allTicket.data!.response
                              .map((e) => e.tickerName ?? "N?A")
                              .toList()
                              .indexOf(currentName)]
                          .ticker;
                      if (currentName.isNotEmpty) {
                        await DatabaseHelperRepository().addTicket(tickerName);
                        Provider.of<TicketController>(context, listen: false)
                            .getUserTicket();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
