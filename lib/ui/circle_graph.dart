import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CircleGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final piedataList = [
      new PieData('Work', 5),
      new PieData('Eat', 10),
      new PieData('TV', 35),
    ];
    var pieDataChart = List<charts.Series<PieData, String>>()
      ..add(
        charts.Series(
          domainFn: (PieData data, _) => data.activity,
          measureFn: (PieData data, _) => data.time,
          id: 'roulette',
          data: piedataList,
          labelAccessorFn: (PieData row, _) => '${row.activity}',
        ),
      );

    return charts.PieChart(
      pieDataChart,
      animate: true,
      animationDuration: Duration(milliseconds: 500),
      layoutConfig: charts.LayoutConfig(
          topMarginSpec: charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          leftMarginSpec: charts.MarginSpec.fixedPixel(0)),
    );
  }
}

class PieData {
  String activity;
  double time;
  PieData(this.activity, this.time);
}
