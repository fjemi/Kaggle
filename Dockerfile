# python version
from python:3.9-rc-slim-buster as build

# set env vars
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

arg port
arg host_ip
arg notebook_dir
# set working directory and copy files
workdir /jupyter
copy ./code .
copy ./data .

workdir /tmp
copy Pipfile* ./

from build as build-dependancies

# install dependancies
run ["sh", "-c", "pip install pipenv"]
run ["sh", "-c", "pipenv lock --keep-outdated --requirements > requirements.txt"]
run ["sh", "-c", "pip install -r requirements.txt"]

# runtime
workdir /jupyter/
expose $port
entrypoint ["sh", "-c", "jupyter lab --allow-root --ip $host_ip"]
