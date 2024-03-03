import 'package:flutter/material.dart';
import 'package:npstock/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData(0, 3),
    ChartData(2.6, 2),
    ChartData(4.9, 5),
    ChartData(6.8, 3.1),
    ChartData(8, 4),
    ChartData(9.5, 3),
    ChartData(11, 4),
    // Add more data points to match your chart data
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: NumericAxis(
        isVisible: false, // Hide the X axis
      ),
      primaryYAxis: NumericAxis(
        isVisible: false, // Hide the Y axis
      ),
      series: <CartesianSeries>[
        LineSeries<ChartData, double>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: Colors.green, // Line color
          width: 2,
          //  gradient: LinearGradient(
          //   colors: [Colors.green, Colors.lightGreenAccent],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        )
      ],
      plotAreaBorderWidth: 0, // Remove plot area border
    );
  }
}
