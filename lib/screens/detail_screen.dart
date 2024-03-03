// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:npstock/controller/ticker_controller.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/app_sizes.dart';
import 'package:npstock/styles/text_styles.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  String currentName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("TICKER"),
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TickerController>(builder: (context, provider, __) {
        switch (provider.allTicker.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case Status.ERROR:
            return const Center(child: Text("Error"));

          case Status.COMPLETED:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingLg * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "NABIL",
                          style: TextStyle(
                            fontSize: 22,
                            height: 1,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDarkGrey,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "2,000.75",
                          style: TextStyle(
                            fontSize: 34,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textGrey,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              "+1.29%",
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.paddingLg * 1.5,
                            ),
                            Text(
                              "+34.4%",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "As on 3 Mar,2023 | 15:59",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // ChartWidget(chartData: chartData),
                    const SizedBox(
                      height: AppSizes.paddingLg * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: provider.durationNames
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                provider.setCurrentDuration(e);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: e == provider.currentDuration
                                      ? AppColors.selectedChipColor
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  e,
                                  style: smallText.copyWith(
                                      color: AppColors.textGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: AppSizes.paddingLg * 2,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EachInfoItem(
                          title: "Shares Traded",
                          subTitle: "4,234242",
                        ),
                        EachInfoItem(
                          title: "Volume",
                          subTitle: "4,234242",
                          isRowAligmentEnd: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.paddingLg * 2,
                    ),
                    const EachInfoItem(
                      title: "Market Cap",
                      subTitle: "5,234242,123213",
                    ),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}

class EachInfoItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isRowAligmentEnd;
  const EachInfoItem({
    Key? key,
    required this.title,
    required this.subTitle,
    this.isRowAligmentEnd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isRowAligmentEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey),
        ),
      ],
    );
  }
}
