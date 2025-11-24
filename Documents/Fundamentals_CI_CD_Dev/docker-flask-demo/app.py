from flask import Flask
import socket
from datetime import datetime
import os

# Simple Flask application to demonstrate running inside Docker vs local environment.
app = Flask(__name__)


@app.route("/")
def index():
    # Get the container/machine hostname
    hostname = socket.gethostname()

    # Get current time inside the running environment (host or container)
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Detect where the app is running:
    # - In Docker: RUN_ENV=docker (set in Dockerfile)
    # - Locally:  RUN_ENV is not set, we default to "local"
    run_env = os.environ.get("RUN_ENV", "local")

    # Human-readable label for the environment
    if run_env == "docker":
        env_label = "Docker container"
    else:
        env_label = "Local environment (venv / host)"

    # Return a simple HTML page with diagnostic information
    return f"""
    <html>
      <head>
        <title>Docker Flask Demo</title>
      </head>
      <body>
        <h1>Hello from Vladimir Kuryndin  Dockerized Flask app!</h1>
        <p>Container hostname: <b>{hostname}</b></p>
        <p>Current time inside environment: <b>{current_time}</b></p>
        <p>Run environment: <b>{env_label}</b></p>
      </body>
    </html>
    """


if __name__ == "__main__":
    # Run the Flask development server.
    # host="0.0.0.0" makes the app accessible from outside the container/VM.
    # port=5000 is the port we expose and map via Docker.
    app.run(host="0.0.0.0", port=5000)

