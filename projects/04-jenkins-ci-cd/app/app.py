from flask import Flask
import os

app = Flask(__name__)

@app.get("/")
def home():
    return {
        "service": "jenkins-cicd-lab",
        "env": os.getenv("APP_ENV", "dev")
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
