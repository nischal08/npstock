// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:npstock/controller/detail_controller.dart';
import 'package:npstock/data/response/api_response.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/model/securities_stats_model.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/app_sizes.dart';
import 'package:npstock/styles/text_styles.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<DetailController>(builder: (context, provider, __) {
        return PageView.builder(
            itemCount: provider.allStats.keys.length,
            itemBuilder: (context, index) {
              return Builder(
                builder: (context) {
                  ApiResponse<SecuritiesStatsModel> apiResponseModel = provider
                      .allStats[provider.allStats.keys.toList()[index]]!;
                  ResponseSSM securitiesStatsModel =
                      apiResponseModel.data!.response;
                  switch (apiResponseModel.status) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case Status.ERROR:
                      return const Center(child: Text("Server Error"));

                    case Status.COMPLETED:
                      DateTime convertedUpdatedDate =
                          DateFormat('yy-MM-dd HH-mm-ss')
                              .parse(securitiesStatsModel.updatedOn);
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingLg * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    securitiesStatsModel.ticker,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      height: 1,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textDarkGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    securitiesStatsModel.ltp.toString(),
                                    style: const TextStyle(
                                      fontSize: 34,
                                      height: 1,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${securitiesStatsModel.pointChange.isNegative ? "-" : "+"}${securitiesStatsModel.pointChange.toString()}",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color:
                                              securitiesStatsModel.pointChange <
                                                      0
                                                  ? Colors.red
                                                  : AppColors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppSizes.paddingLg,
                                      ),
                                      Text(
                                        "${securitiesStatsModel.percentageChange.isNegative ? "-" : "+"}${securitiesStatsModel.percentageChange.toString()}%",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: securitiesStatsModel
                                                  .percentageChange.isNegative
                                              ? Colors.red
                                              : AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // 3 Mar,2023
                                  Text(
                                    "As on ${DateFormat("d MMM, yyyy").format(convertedUpdatedDate)} | ${DateFormat("hh:mm").format(convertedUpdatedDate)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                              const SizedBox(
                                height: AppSizes.paddingLg * 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EachInfoItem(
                                    title: "Shares Traded",
                                    value: securitiesStatsModel.sharesTraded
                                        .toString(),
                                  ),
                                  EachInfoItem(
                                    title: "Volume",
                                    value: securitiesStatsModel.volume == 0.0
                                        ? "N/A"
                                        : securitiesStatsModel.volume
                                            .toString(),
                                    isRowAligmentEnd: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppSizes.paddingLg * 2,
                              ),
                              EachInfoItem(
                                title: "Market Cap",
                                value:
                                    securitiesStatsModel.marketCap.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              );
            });
      }),
    );
  }
}

class EachInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isRowAligmentEnd;
  const EachInfoItem({
    Key? key,
    required this.title,
    required this.value,
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
          value,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey),
        ),
      ],
    );
  }
}
