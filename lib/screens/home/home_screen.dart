import 'package:flutter/material.dart';
import 'package:npstock/controller/detail_controller.dart';
import 'package:npstock/controller/ticker_controller.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/model/watch_list_model.dart';
import 'package:npstock/screens/home/widgets/home_ticker_info_item.dart';
import 'package:npstock/screens/ticker_select_screen.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/text_styles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TickerController>(context, listen: false).getAllTicker();
    Provider.of<TickerController>(context, listen: false).getUserTicker();
    Provider.of<DetailController>(context, listen: false).getAllStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              const Text(
                "My Watchlist",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TickerSelectScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.blue,
                        size: 28,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<TickerController>(context, listen: false)
                          .setShowDelete();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Consumer<TickerController>(
                          builder: (context, provider, __) {
                        return Icon(
                          provider.showDelete ? Icons.check : Icons.close,
                          color: AppColors.blue,
                          size: 22,
                        );
                      }),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<TickerController>(builder: (context, provider, __) {
                switch (provider.userTicker.status) {
                  case Status.LOADING:
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 150),
                      child: const CircularProgressIndicator(),
                    );
                  case Status.ERROR:
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 150),
                      child: Text(provider.userTicker.message!),
                    );
                  case Status.COMPLETED
                      when provider.userTicker.data!.response.isEmpty:
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 150),
                      child: Text(
                        "Please add your ticker above.",
                        textAlign: TextAlign.center,
                        style: titleText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  case Status.COMPLETED:
                    return Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                          itemCount: provider.userTicker.data!.response.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            ResponseDataWL responseData =
                                provider.userTicker.data!.response[index];
                            return HomeTickerInfoItem(
                              index: index,
                              responseData: responseData,
                              isBottomPadding: index ==
                                  provider.userTicker.data!.response.length - 1,
                              showdelete: provider.showDelete,
                              onDelete: () {
                                Provider.of<TickerController>(context,
                                        listen: false)
                                    .deleteUserTicker(index);
                              },
                            );
                          },
                        ),
                      ),
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
