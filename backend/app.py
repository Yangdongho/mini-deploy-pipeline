from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
 return os.getenv("APP-MESSAGE", "Flask Backend")

@app.route("/health")
def health():
 return "OK"

app.run(host="0.0.0.0", port=5000)



