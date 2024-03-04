import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartDataModel> chartData;

  const ChartWidget({super.key, required this.chartData});
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const DateTimeAxis(isVisible: false),
      primaryYAxis: const NumericAxis(
        isVisible: false,
      ),
      series: <CartesianSeries>[
        AreaSeries<ChartDataModel, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartDataModel data, _) => data.x,
          yValueMapper: (ChartDataModel data, _) => data.y,
          color: Colors.green[100],
          borderColor: Colors.green,
          borderWidth: 2,
        )
      ],
      plotAreaBorderWidth: 0,
    );
  }
}
