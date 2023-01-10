import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});
  final List<Color> graidentColor = [
    Color(0xffFEF2F9),
    Color(0xffFFDEEF),
    Color(0xffFFD9EE),
    Color(0xffE859A3),
    Color.fromARGB(255, 151, 119, 135),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
                drawBehindEverything: true,
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: topTitleWidgets))),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(strokeWidth: 1, color: Colors.black.withOpacity(.1));
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.transparent);
          },
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 80,
        lineBarsData: [
          LineChartBarData(
              show: true,
              gradient: LinearGradient(
                  colors: graidentColor.map((e) => e.withOpacity(.7)).toList()),
              isCurved: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                  color: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xffFEF2F9),
                        Color(0xffFFDEEF),
                        Color(0xffFFD9EE),
                        Color(0xffE859A3),
                        // Color.fromARGB(255, 151, 119, 135),
                      ]),
                  show: true),
              // aboveBarData: BarAreaData(
              //     gradient: const LinearGradient(
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter,
              //         colors: [
              //           Color(0x0fffef29),
              //           Color.fromARGB(255, 154, 32, 95),
              //           Color(0xffFFD9EE),
              //           Color(0xffE859A3),
              //         ]),
              //     show: true),
              dotData: FlDotData(
                show: false,
              ),
              spots: const [
                FlSpot(0, 20),
                FlSpot(2, 18),
                FlSpot(4.9, 38),
                FlSpot(6.8, 64),
                FlSpot(8, 22),
                FlSpot(9.5, 10),
                FlSpot(11, 60),
              ]),
        ]));
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Container(
            //  margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withOpacity(.2)),
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: const Center(child: Text('Jan', style: style)));
        break;

      case 2:
        text = Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withOpacity(.2)),
                //color: Colors.red,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: const Center(child: Text('Feb', style: style)));
        break;
      case 4:
        text = Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withOpacity(.2)),
                color: Color(0xffEA1597),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: const Center(
                child: Text('Mar', style: TextStyle(color: Colors.white))));
        ;
        break;
      case 6:
        text = Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withOpacity(.2)),
                // color: Color(0xffEA1597),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: const Center(child: Text('Apr', style: style)));
        break;
      case 8:
        text = Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withOpacity(.2)),
                // color: Color(0xffEA1597),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: const Center(child: Text('May', style: style)));
        ;
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
