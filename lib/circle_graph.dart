import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CircleGraph extends StatefulWidget {
  @override
  _CircleGraphState createState() => _CircleGraphState();
}

class _CircleGraphState extends State<CircleGraph> {
  List<charts.Series<PieData, String>> _pieData;

  @override
  void initState() {
    super.initState();

    final piedata = [
      new PieData('Work', 35.8),
      new PieData('Eat', 8.3),
      new PieData('Commute', 10.8),
      new PieData('TV', 15.6),
      new PieData('Sleep', 19.2),
      new PieData('Other', 10.3),
    ];
    _pieData = List<charts.Series<PieData, String>>();
    _pieData.add(
      charts.Series(
        domainFn: (PieData data, _) => data.activity,
        measureFn: (PieData data, _) => data.time,
        id: 'Time spent',
        data: piedata,
        labelAccessorFn: (PieData row, _) => '${row.activity}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      _pieData,
      animate: true,
      animationDuration: Duration(milliseconds: 500),
      layoutConfig:
          charts.LayoutConfig(topMarginSpec: charts.MarginSpec.fixedPixel(0)),
    );
  }
}

class PieData {
  String activity;
  double time;
  PieData(this.activity, this.time);
}
