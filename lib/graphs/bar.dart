import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.transparent,
        child: BarChart(
          BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                      ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: const Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                      color: const Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Lundi';
                      case 1:
                        return 'Mardi';
                      case 2:
                        return 'Mercredi';
                      case 3:
                        return 'Jeudi';
                      case 4:
                        return 'Vendredi';
                      case 5:
                        return 'Samedi';
                      case 6:
                        return 'Dimanche';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: const SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(y: 9, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(y: 12, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(y: 6, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: 13, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: 12, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: 3, color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
              ]),
        ),
      ),
    );
  }
}