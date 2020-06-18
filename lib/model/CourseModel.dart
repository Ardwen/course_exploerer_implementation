import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'filterData.dart';
class CourseModel {
  String courseName;
  String courseID;
  double courseAvg;
  int A;
  int B;
  int C;
  int D;
  int F;
  int courseStudents;
  List<String> professor_names;

  CourseModel({this.courseName, this.courseID, this.courseAvg,
    this.A, this.B, this.C, this.D, this.F, this.courseStudents, this.professor_names = const [
    ]});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return new CourseModel(
        courseName: json['course_name'],
        courseAvg: json['avg_gpa'],
        courseID: json['course_id'],
        A: json['A'],
        B: json['B'],
        C: json['C'],
        D: json['D'],
        F: json['F'],
        courseStudents: json['course_students'],
        professor_names: ProfessorList.fromProfessorsJson(json['professors']).professorList
    );
  }
}

class ProfessorList {
  List<String> professorList;
  ProfessorList({this.professorList});
  factory ProfessorList.fromProfessorsJson(List<dynamic> professors) {
    if (professors == null) {
      return new ProfessorList(professorList: []);
    }
    return new ProfessorList(professorList: professors.map((item) => item['professor_name']).toList());
  }
}