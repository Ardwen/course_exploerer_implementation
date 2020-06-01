import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'filterData.dart';

class BarChartSample1 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  
  //dummy data
  List<Term> term1 = new List<Term>();
  Term t11 = new Term('FALL 2019', 357,18,11,13,23);
  List<Term> term2 = new List<Term>();
  Term t21 = new Term('SPR 2018', 66, 88, 15, 1, 0);
  Term t22 = new Term('SPR 2017', 54, 23, 12, 1, 0);

  int touchedIndex = -1;

  bool isPlaying = false;

  Professor _professor;

  Term _curterm;

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
          y: y.toDouble(),
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
    term1.add(t11);
    Professor profes1 = new Professor("Challen, Geoffrey W", 3.8, term1);
    term2.add(t22);
    term2.add(t21);
    Professor profes2 = new Professor("Chapman, William L", 3.0, term2);
    _professor = profes1;
    return DropdownButton<Professor>(
      items: [
        DropdownMenuItem<Professor>(
          child: Text(profes1.name),
          value: profes1,
        ),
        DropdownMenuItem<Professor>(
          child: Text(profes2.name),
          value: profes2,
        ),
        /*DropdownMenuItem<Professor>(
          child: Text(profes3.name),
          value: profes3,
        ),*/
      ],
      onChanged: (value) {
        setState(() {
          _professor = value;
        });
      },
      hint: Text('Select Item'),
      //value: _value,
      isExpanded: true,
      value: _professor,
    );
  }
  
  //drop down button
  DropdownButton _TermDown () {
    _curterm = t11;
    return DropdownButton<Term>(
      items: [
        DropdownMenuItem(
          value: t11,
          child: Text(t11.term),
        ),
        DropdownMenuItem(
          value: t21,
          child: Text(t21.term),
        )
      ],//_dropDowntermItem(),
      onChanged: (value){
        setState(() {
          _curterm = value;
        });
     },
      value: _curterm,
      hint: Text('Select Term'),
      isExpanded: true,
    );
  }

  /*List<DropdownMenuItem<Term>> _dropDowntermItemDefault() {
    List<DropdownMenuItem<Term>> l = new List<DropdownMenuItem<Term>>();
    l.add(
        new DropdownMenuItem(
          child: Text("N/A"),
        )
    );
    return l;
  }*/

  //drop down term items 
  List<DropdownMenuItem<Term>> _dropDowntermItem(){
    return _professor.terms.map(
        (value) => DropdownMenuItem(
          value: value,
          child: Text(value.term),
        )
    ).toList();
  }
  
  //Data after selections
  /*BarChartData filterData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
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
      barGroups: List.generate(5, (i) {
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
      }),
    );
  }*/

  /*Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }*/
}