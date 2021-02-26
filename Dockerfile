# build image
from archlinux:latest as build

# env variables to use
arg port
arg host_ip
arg notebook_dir

# set working directory and copy files
workdir /$notebook_dir
copy Pipfile* ./
copy ./notebooks ./notebooks
copy ./extensions ./extensions

# install packages
run ["sh", "-c", "pacman -Syu --noconfirm"]
run ["sh", "-c", "pacman -S nodejs yarn npm python python-pipenv --noconfirm"]

# create temporary image to download dependancies
from build as intermediate

# install dependancies
#run ["sh", "-c", "pip install pipenv"]
run ["sh", "-c", "pipenv lock --keep-outdated"]
run ["sh", "-c", "mkdir .venv && pipenv install"]

# runtime
expose $port
entrypoint ["sh", "-c", "pipenv run jupyter lab --allow-root --ip $host_ip --port $port"]
