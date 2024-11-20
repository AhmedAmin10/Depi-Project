import 'dart:core';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/dart_data.dart';

class MyBarGraph extends StatelessWidget {
  final Map<int, double> daysAmount;
  final double? maxY;
  const MyBarGraph({super.key, required this.daysAmount, required this.maxY});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(daysAmount: daysAmount);
    myBarData.initialize();
    return BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
            // getTitlesWidget: getUpperTitles
          )),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: const Color(0xff272e81),
                      width: 25,
                      borderRadius: BorderRadius.circular(20),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,
                        color: const Color(0xff9496c1),
                      ))
                ]))
            .toList()));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff272e81),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Map<int, String> days = {
      0: "S",
      1: "S",
      2: "M",
      3: "T",
      4: "W",
      5: "T",
      6: "F"
    };
    Widget text = Text(
      days[value.toInt()]!,
      style: style,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

// Widget getUpperTitles(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Color(0xff272e81),
//     fontWeight: FontWeight.bold,
//     fontSize: 14,
//   );
//
//   Widget text = Text(
//     "${daysAmount[value.toInt()]} LE",
//     style: style,
//   );
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: text,
//   );
// }
}
