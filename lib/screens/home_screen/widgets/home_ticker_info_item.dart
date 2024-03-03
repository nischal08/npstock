import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data.dart';
import 'package:npstock/model/watch_list_model.dart';
import 'package:npstock/screens/detail_screen.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/widgets/chart_widget.dart';

class HomeTickerInfoItem extends StatelessWidget {
  const HomeTickerInfoItem({
    super.key,
    required this.responseData,
    required this.isBottomPadding,
  });

  final ResponseData responseData;
  final bool isBottomPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(),
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
                      (e) => ChartData(
                        e.timestamp,
                        e.value,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              width: 2,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  responseData.ltp.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      responseData.pointChange.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "${responseData.percentageChange}%",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
