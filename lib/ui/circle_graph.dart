import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CircleGraph extends StatelessWidget {
  final List<PieData> pieDataList;
  const CircleGraph({this.pieDataList});

  @override
  Widget build(BuildContext context) {
    var pieDataChart = List<charts.Series<PieData, String>>()
      ..add(
        charts.Series(
          domainFn: (PieData data, _) => data.name,
          measureFn: (PieData data, _) => data.percentage,
          id: 'roulette',
          data: pieDataList,
          labelAccessorFn: (PieData row, _) => '${row.name}',
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
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ],
      ),
    );
  }
}

class PieData {
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  double _percentage;

  double get percentage => _percentage;

  set percentage(double percentage) {
    _percentage = percentage;
  }

  PieData(this._name, this._percentage);
}
