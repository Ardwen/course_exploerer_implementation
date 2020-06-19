import 'dart:async';
import 'dart:math';

import 'package:coursegpa/model/CourseModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'model/filterData.dart';

class BarChartSample1 extends StatefulWidget {
  CourseModel course;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  CourseModel course;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  
  //todo Term model
  Term t0 = new Term('N/A', 0,0,0,0,0);
  List<Term> term2 = <Term>[Term('FALL 2019', 357,18,11,13,23),Term('SPR 2018', 66, 88, 15, 1, 0)];
  List<Term> term1 = <Term>[Term('SPR 2017', 54, 23, 12, 1, 0)];
  Professor profes1;
  Professor profes2;

  int touchedIndex = -1;

  bool isPlaying = false;

  Professor _professor;

  String _professor_name;

  Term _curterm;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                        Expanded(
                          child:_ProfessorDown(),
                        ),
                      Expanded(
                        child:_TermDown(),
                      ),
                    ],
                  ),//row
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        //swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      int y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y.toDouble()+1.0,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
  
  //default bar data Groups
  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, 0, isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, 0, isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, 0, isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, 0, isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, 0, isTouched: i == touchedIndex);
      default:
        return null;
    }
  });
  
  
  //filtered DataGroups

  List<BarChartGroupData> filterGroups() => List.generate(5, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, _curterm.a, isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, _curterm.b, isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, _curterm.c, isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, _curterm.d, isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, _curterm.f, isTouched: i == touchedIndex);
      default:
        return null;
    }
  });
  
  
  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String gradeLevel;
              switch (group.x.toInt()) {
                case 0:
                  gradeLevel = 'A';
                  break;
                case 1:
                  gradeLevel = 'B';
                  break;
                case 2:
                  gradeLevel = 'C';
                  break;
                case 3:
                  gradeLevel = 'D';
                  break;
                case 4:
                  gradeLevel = 'F';
                  break;
              }
              return BarTooltipItem(
                  gradeLevel + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'A';
              case 1:
                return 'B';
              case 2:
                return 'C';
              case 3:
                return 'D';
              case 4:
                return 'F';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: filterGroups(),
      // _curterm == null? showingGroups():
    );
  }


  //dropDown professor names
  DropdownButton _ProfessorDown() {
    return
      DropdownButton<String>(
      items: course.professor_names.map((String pp) {
        return  DropdownMenuItem<String>(
          value: pp,
          child: Text(pp),
        );
      }).toList(),
      onChanged: (String newprof) {
        setState(() {
          _curterm = t0;
          _professor = getProfessorDetail(newprof);
          _professor_name = newprof;
        });
      },
      hint: Text('Select Item'),
      //value: _value,
      isExpanded: true,
      value: _professor_name,
    );
  }
  
  //drop down button
  DropdownButton<Term> _TermDown () {
    return DropdownButton<Term>(
      value: _curterm,
      onChanged: (Term newt){
        setState(() {
          _curterm = newt;
        });
      },
      items: _professor.terms.map((Term tt) {
        return  DropdownMenuItem<Term>(
          value: tt,
          child:
              Text(
                tt.term,
              ),
        );
      }).toList(),
      hint: Text('Select Term'),
      isExpanded: true,
    );
  }
}