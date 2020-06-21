import "package:http/http.dart" as http;
import 'dart:convert';
import "model/CourseModel.dart";
import "model/filterData.dart";

var host = 'http://10.0.2.2:5000';

Future<CourseModel> getCourseGPA(String courseid) async {

  final response = await http.get('http://10.0.2.2:5000/course/ACCY200');
  if (response.statusCode == 200) {
    return CourseModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load course');
  }
}

Future<Professor> getProfessorGPA(String professorname, String courseid) async {
  final response = await http.get(host+'/course/' + courseid + '/'+ professorname);
  if (response.statusCode == 200) {
    return Professor.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load course');
  }
}
//todo getProfessorGPA