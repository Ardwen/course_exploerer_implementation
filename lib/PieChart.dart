import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';
import 'model/CourseModel.dart';
import 'DataService.dart';

class PieChartSample2 extends StatefulWidget {

  String courseID;
  PieChartSample2(this.courseID);
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;
  CourseModel course;
  bool _isLoading = false;

  @override
  void initState() {
    _loadCourseDetail();
    super.initState();
  }

  void _loadCourseDetail() {
    _isLoading = true;
    getCourseGPA(widget.courseID).then((CourseModel detailcourse) {
      this.setState(() {
        course = detailcourse;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading? Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )
      ],
    )
    : AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  //todo fix string
                  'GPA: '+course.courseAvg,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 21)
                ),
                SizedBox(
                  height: 25,
                ),
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'A',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'B',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'C',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'D',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff9e9e9e),
                  text: 'F',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

    List<PieChartSectionData> showingSections() {
      return List.generate(5, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 10;
        final double radius = isTouched ? 60 : 50;
        switch (i) {
          case 0:
            //todo fix value
            return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: double(course.A),
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            );
          case 3:
            return PieChartSectionData(
              color: const Color(0xff13d38e),
              value: 10,
              title: '10%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            );
          case 4:
            return PieChartSectionData(
              color: const Color(0xff9e9e9e),
              value: 5,
              title: '5%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            );
          default:
            return null;
        }
      });
    }
  }
