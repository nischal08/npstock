import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartWidget({super.key, required this.chartData});
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const DateTimeAxis(isVisible: false),
      primaryYAxis: const NumericAxis(
        isVisible: false, 
      ),
      series: <CartesianSeries>[
        AreaSeries<ChartData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: Colors.green[100],
          borderColor: Colors.green,
          borderWidth: 2,
        )
      ],
      plotAreaBorderWidth: 0,
    );
  }
}
