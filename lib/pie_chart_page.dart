import 'package:flutter/material.dart';

import 'pieChart.dart';
import 'barChart.dart';

class PieChartPage extends StatelessWidget {
  final Color barColor = Colors.white;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final double width = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffeceaeb),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'CS 125 Intrduction to Programming',
                  style: TextStyle(
                      color: Color(
                        0xff333333,
                      ),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            PieChartSample2(),
            const SizedBox(
              height: 18,
            ),
            BarChartSample1(),
          ],
        ),
      ),
    );
  }
}