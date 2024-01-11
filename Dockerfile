FROM --platform=linux/amd64 python:3.10-slim-buster

RUN apt-get update \
    && apt-get install -y --no-install-recommends 

WORKDIR /usr/src/dbt

# Install the dbt Postgres adapter. This step will also install dbt-core
RUN pip install --upgrade pip
RUN pip install dbt-postgres==1.2.0
RUN pip install pytz

# Install dbt dependencies (as specified in packages.yml file)
# Build seeds, models and snapshots (and run tests wherever applicable)
# The sleep command is designed to pause command execution for a specified amount of time. 
# By specifying infinity , you are effectively instructing the system to sleep indefinitely, 
# thus preventing the container from shutting down, as there is always an active process.
CMD dbt deps && dbt build --profiles-dir ./profiles && sleep infinity
