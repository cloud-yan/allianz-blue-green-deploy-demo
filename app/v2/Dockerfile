FROM python:3.9-slim
WORKDIR /app
COPY ./v2/ .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]