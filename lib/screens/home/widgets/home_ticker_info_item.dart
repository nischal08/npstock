import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data_model.dart';
import 'package:npstock/model/watch_list_model.dart';
import 'package:npstock/screens/detail/detail_screen.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/widgets/chart_widget.dart';

class HomeTickerInfoItem extends StatelessWidget {
  final int index;
  final bool showdelete;
  final VoidCallback onDelete;
  const HomeTickerInfoItem({
    super.key,
    required this.responseData,
    required this.isBottomPadding,
    required this.showdelete,
    required this.onDelete,
    required this.index,
  });

  final ResponseDataWL responseData;
  final bool isBottomPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(index: index),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: isBottomPadding ? 32 : 0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Row(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                  responseData.icon,
                  fit: BoxFit.scaleDown,
                )),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
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
                    responseData.tickerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            SizedBox(
                width: 110,
                height: 80,
                child: ChartWidget(
                  chartData: [
                    ...responseData.chartData.map(
                      (e) => ChartDataModel(
                        e.timestamp,
                        e.value,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              width: 2,
            ),
            // const Spacer(),
            showdelete
                ? GestureDetector(
                    onTap: onDelete,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          responseData.ltp.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.bold,
                          ),
                          minFontSize: 12,
                          maxFontSize: 22,
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              flex: 1,
                              child: AutoSizeText(
                                responseData.pointChange.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: responseData.pointChange.isNegative
                                      ? Colors.red
                                      : AppColors.green,
                                ),
                                maxFontSize: 16,
                                minFontSize: 12,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Flexible(
                              flex: 1,
                              child: AutoSizeText(
                                "${responseData.percentageChange}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      responseData.percentageChange.isNegative
                                          ? Colors.red
                                          : AppColors.green,
                                ),
                                maxFontSize: 16,
                                minFontSize: 12,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
