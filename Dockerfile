FROM python:3

# Install requirements
COPY requirements.txt ./
RUN apt-get update
RUN pip install -r requirements.txt

# Config env
ENV READ_BUCKET="vi-etl-dev-bucket-test-1"
ENV READ_DATA_PATH=data
ENV WRITE_BUCKET="vi-etl-dev-bucket-test-2"
ENV WRITE_DATA_PATH=results

# Install application
COPY config.py ./
COPY app.py ./

# Run application
CMD ["python","-u","app.py"]