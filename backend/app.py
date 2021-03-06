from flask import Flask
from flask_restx import Api
from . import api as courseapi
from flask_mongoengine import MongoEngine

app = Flask(__name__)

DB_URL = 'mongodb+srv://user1:rockwire@cluster0-wlgwx.mongodb.net/grade_db?retryWrites=true&w=majority'
app.config['MONGODB_HOST'] = DB_URL
db = MongoEngine()
db.init_app(app)


api = Api(app)
api.add_namespace(courseapi, path='/course')

app.run(host='0.0.0.0')

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
