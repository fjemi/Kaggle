# build image
from archlinux:latest as build

# env variables to use
arg port
arg ip
arg base_dir

# set working directory and copy files
workdir /$base_dir
copy Pipfile* ./
copy startup.sh ./
copy notebooks ./notebooks
copy extensions ./extensions

# install packages
run ["sh", "-c", "pacman -Syu --noconfirm"]
run ["sh", "-c", "pacman -S nodejs yarn npm git python python-pipenv --noconfirm"]

# create temporary image to download dependancies
from build as intermediate

# install dependancies
run ["sh", "-c", "pipenv lock --keep-outdated"]
#run ["sh", "-c", "mkdir .venv && pipenv install"]
run ["sh", "-c", "pipenv install --deploy --system"]

# make shell script an executable
run ["sh", "-c", "chmod +x startup.sh"]

# runtime
expose $port
entrypoint ["sh", "-c", "./startup.sh"]
