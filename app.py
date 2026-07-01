from flask import Flask, g, escape, session, redirect, render_template, request, jsonify, Response
from Misc.functions import *

app = Flask(__name__)
app.secret_key = '#$ab9&^BB00_.'

# Setting DAO Class
from Models.DAO import DAO

DAO = DAO(app)

# Registering blueprints
from routes.user import user_view
from routes.book import book_view
from routes.admin import admin_view

# Registering custom functions to be used within templates
app.jinja_env.globals.update(
    ago=ago,
    str=str,
)

app.register_blueprint(user_view)
app.register_blueprint(book_view)
app.register_blueprint(admin_view)

# Prometheus metrics
from flask import Flask, g, escape, session, redirect, render_template, request, jsonify, Response
from Misc.functions import *
from prometheus_client import generate_latest, CONTENT_TYPE_LATEST, Summary, Counter
import time

REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')
REQUEST_COUNTER = Counter('flask_requests_total', 'Total number of requests', ['method', 'endpoint'])

@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

@app.before_request
def before_request():
    request.start_time = time.time()

@app.after_request
def after_request(response):
    request_time = time.time() - request.start_time
    REQUEST_TIME.observe(request_time)
    REQUEST_COUNTER.labels(method=request.method, endpoint=request.path).inc()
    return response


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)