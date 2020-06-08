from .database import db


class Term(db.EmbeddedDocument):
    term_name = db.StringField(required=True, unique=True)
    A = db.IntField()
    B = db.IntField()
    C = db.IntField()
    D = db.IntField()
    F = db.IntField()


class Professor(db.EmbeddedDocument):
    professor_name = db.StringField(required=True, unique=True)
    professor_avg = db.FloatField()
    terms = db.EmbeddedDocumentListField(Term)


class Course(db.Document):
    course_id = db.StringField(required=True, unique=True)
    course_name = db.StringField(required=True, unique=True)
    avg_gpa = db.FloatField()
    professors = db.EmbeddedDocumentListField(Professor)





