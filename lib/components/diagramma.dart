import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../resurs/global.dart';



///Диаграмма

class MyDiagramma extends StatefulWidget {
  MyDiagramma({Key? key}) : super(key: key);

  @override
  _MyDiagrammaState createState() => _MyDiagrammaState();
}

class _MyDiagrammaState extends State<MyDiagramma> {
  List<_SalesData> data = [];





@override
  void initState() {
  grafikInfo.forEach((key, value) { data.add(_SalesData(key.split('-').take(2).join('.').toString(), double.parse(value.toString())),);});
    // TODO: implement initState
    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SfCartesianChart(
              backgroundColor: MyColors().myWhite,
                primaryXAxis: CategoryAxis(
                  crossesAt: 0
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'сумма', textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  rangePadding: ChartRangePadding.auto,
                  numberFormat: NumberFormat.compact(),
                ),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                    markerSettings: MarkerSettings(
                      width: 5,
                      height: 5,
                      borderWidth: 0,
                      isVisible: true,
                      color: Colors.indigo,
                    ),
                    color: Colors.indigo[300],
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
            ),
          ]),
        ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;

}