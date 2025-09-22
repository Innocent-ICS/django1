FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Set environment variables
ENV PYTHONPATH=/app
ENV DJANGO_SETTINGS_MODULE=cloudlab.settings
ENV PORT=8080
ENV DEBUG=False

# Collect static files (note the path to manage.py)
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8080

# Run the application (point to cloudlab/cloudlab/wsgi.py)
CMD python manage.py migrate --noinput && \
    exec gunicorn --bind :$PORT --workers 1 --threads 8 cloudlab.wsgi:application