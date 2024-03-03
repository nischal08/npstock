import 'package:flutter/material.dart';
import 'package:npstock/controller/ticket_controller.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/model/watch_list_model.dart';
import 'package:npstock/screens/ticket_select_screen.dart';
import 'package:npstock/widgets/chart_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<TicketController>(context, listen: false).getAllTicket();
    Provider.of<TicketController>(context, listen: false).getUserTicket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      appBar: AppBar(title: const Text("NP STOCKS")),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      //TODO: add watch list

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TicketSelectScreen(),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //TODO: delete watch list
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Consumer<TicketController>(builder: (context, provider, __) {
                switch (provider.userTicket.status) {
                  case Status.LOADING:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  case Status.ERROR:
                    return const Center(child: Text("Error"));
                  case Status.COMPLETED
                      when provider.userTicket.data!.response.isEmpty:
                    return const Center(
                      child: Text("Please add your ticket above"),
                    );
                  case Status.COMPLETED:
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: provider.userTicket.data!.response.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        ResponseData responseData =
                            provider.userTicket.data!.response[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              )),
                          child: Row(
                            children: [
                              Image.network(responseData.icon),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    responseData.ticker,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  Text(
                                    responseData.ticker,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: 120, height: 80, child: ChartWidget()),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    responseData.ltp.toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        responseData.pointChange.toString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.green),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${responseData.percentageChange}%",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              })
            ],
          )),
    );
  }
}
