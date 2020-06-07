from flask import Request, Response
from .datasource.grademodel import Course, Professor, Term
from flask_restx import Resource

class CourseApi():
