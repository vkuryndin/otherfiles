# Use official Python 3.9 slim image as base (from Docker Hub)
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Environment variables to make Python behave nicely in containers
# - do not write .pyc files
# - do not buffer stdout/stderr (logs appear immediately)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# explictily specifying that we are running in docker environment
ENV RUN_ENV=docker

# Copy dependency file into the image
COPY requirements.txt /app/

# Install Python dependencies inside the image
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code into the image
COPY app.py /app/

# Document the port the app listens on
EXPOSE 5000

# Command that will be executed when the container starts
CMD ["python", "app.py"]
