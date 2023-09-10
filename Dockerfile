# Use an official Python runtime as the parent image
FROM python:3.8-slim

# Set environment variables for Django and Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE=SocioSync.settings

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container
COPY . /app/

# Expose port for the Django app to run on
EXPOSE 8000

# Start Django's development server (consider using a production server like Gunicorn for production deployments)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
