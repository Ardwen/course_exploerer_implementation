from flask import Flask
from .datasource.database import initialize_db
app = Flask(__name__)

app.config['MONGODB_SETTINGS']={
    'host':'mongodb://localhost/grade'
}

initialize_db(app)
