FROM apache/airflow:2.10.4

USER root

RUN groupadd docker
RUN usermod -aG docker airflow

USER airflow

COPY requirements.txt .

RUN pip install -r requirements.txt