import 'package:flutter/material.dart';

import 'PieChart.dart';
import 'BarChart.dart';
import 'model/CourseModel.dart';
import 'DataService.dart';

class CoursePageArgument{
  final String courseID;
  CoursePageArgument(this.courseID);
}

class PieChartPage extends StatefulWidget {
  static const routeName = '/GPAchartPage';
  String courseID;
  PieChartPage({this.courseID});
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}


class PieChartPageState extends State<PieChartPage>  {
  final Color barColor = Colors.white;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final double width = 22;

  CourseModel course;
  bool _isLoading = false;
  //static const String courseAVG = 'a';

  @override
  void initState() {
    _loadCourseDetail();
    super.initState();
  }

  void _loadCourseDetail() {
    _isLoading = true;
    //"widget.courseID"
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
    ) : Container(
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
                  'Introduction to Accounting',
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
            PieChartSample2(course),
            const SizedBox(
              height: 18,
            ),
            BarChartSample1(course),
          ],
        ),
      ),
    );
  }
}