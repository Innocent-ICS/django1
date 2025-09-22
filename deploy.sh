#!/bin/bash
echo "Starting deployment..."
cd cloudlab
python manage.py collectstatic --noinput
python manage.py migrate
echo "Deployment complete!"