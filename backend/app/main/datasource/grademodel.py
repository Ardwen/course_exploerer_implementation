from .database import db


class Term(db.EmbeddedDocument):
    term_name = db.StringField(required=True, unique=True)
    A = db.Intfield()
    B = db.Intfield()
    C = db.Intfield()
    D = db.Intfield()
    F = db.Intfield()


class Professor(db.EmbeddedDocument):
    professor_name = db.StringField(required=True, unique=True)
    professor_avg = avg_gpa = db.FloatField()
    terms = db.EmbeddedDocumentListField(Term)


class Course(db.Document):
    course_id = db.StringField(required=True, unique=True)
    course_name = db.StringField(required=True, unique=True)
    avg_gpa = db.FloatField()
    professors = db.EmbeddedDocumentListField(Professor)





