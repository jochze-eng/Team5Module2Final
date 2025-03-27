FROM python:3.10

# Setting the working directory
WORKDIR /usr/app

# Copying the project files
COPY models models
COPY tests tests
COPY snapshots snapshots
COPY macros macros
COPY dbt_project.yml dbt_project.yml
COPY profiles.yml /usr/app/profiles.yml
#COPY requirements.txt requirements.txt
#COPY packages.yml packages.yml
#COPY dbt_run.py /usr/app/

# Installing dependencies
RUN pip install --upgrade pip
RUN pip install dbt-databricks
RUN pip install dbt-bigquery
RUN dbt deps

# Setting the entrypoint
#CMD ["python", "/usr/app/dbt_run.py"]