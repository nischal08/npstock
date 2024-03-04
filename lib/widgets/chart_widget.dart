import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data_model.dart';
import 'package:npstock/styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartDataModel> chartData;

  const ChartWidget({super.key, required this.chartData});
  @override
  Widget build(BuildContext context) {
    return chartData.length == 1
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "Only one chart data from api. Please try later.",
                textAlign: TextAlign.center,
                style: subTitleText,
              ),
            ),
          )
        : SfCartesianChart(
            primaryXAxis: const DateTimeAxis(isVisible: false),
            primaryYAxis: const NumericAxis(
              isVisible: false,
            ),
            series: <CartesianSeries>[
              AreaSeries<ChartDataModel, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartDataModel data, _) => data.x,
                yValueMapper: (ChartDataModel data, _) => data.y,
                // color: Colors.green[100],
                borderColor: Colors.green,
                borderWidth: 2,
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.green[200]!, // Top color
                    Colors.white, // Bottom color
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            ],
            plotAreaBorderWidth: 0,
          );
  }
}
