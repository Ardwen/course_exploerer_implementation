import "package:http/http.dart" as http;
import 'dart:convert';
import "model/CourseModel.dart";

var host = 'http://10.0.2.2:5000';

Future<CourseModel> getCourseGPA(String courseid) async {
  final response = await http.get(host+'/course/' + courseid);
  if (response.statusCode == 200) {
    return CourseModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load course');
  }
}

//todo getProfessorGPA