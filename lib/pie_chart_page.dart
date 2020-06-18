import 'package:flutter/material.dart';

import 'PieChart.dart';
import 'BarChart.dart';
import 'model/CourseModel.dart';
import 'DataService.dart';

class CoursePageArgument{
  final String courseID;
  final String courseName;
  CoursePageArgument(this.courseID,this.courseName);
}


class PieChartPage extends StatelessWidget {
  final Color barColor = Colors.white;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final double width = 22;

  static const routeName = '/GPAchartPage';

  @override
  Widget build(BuildContext context) {
    final CoursePageArgument args = ModalRoute.of(context).settings.arguments;
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
                  //ars.courseID+args.courseName,
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
            //PieChartSample2(args.courseID),
            PieChartSample2('ACCY200'),
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