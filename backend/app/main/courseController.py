from flask import Request, Response
from .datasource.grademodel import Course, Professor, Term
from flask_restx import Resource
from .dto import CourseDto

api = CourseDto.api


@api.route('/<course_id>')
@api.param('course_id')
@api.response(404, 'User not found.')
class Course(Resource):
    def get(self,course_id):
        try:
            _course = Course.objects.get(course_id=course_id).tojson
            return Response(_course, mimetype="application/json", status=200)
        except Course.DoesNotExist:
            api.abort(404)






