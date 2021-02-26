# See https://minrk-notebook.readthedocs.io/en/latest/config.html for more information.

import os
from os import getenv

def get_env(s: str) -> str:
  variable = getenv(s)
  if variable is None:
    return ''
  return variable


#c = get_config()


c.ServerApp.token = get_env('token')
c.ServerApp.password = get_env('password')
c.ServerApp.ip = get_env('ip')
c.ServerApp.port = int(get_env('port'))
c.ServerApp.open_browser = bool(get_env('open_browser'))
c.ServerApp.notebook_dir = get_env('notebook_dir')
c.ServerApp.tornado_settings = {
  'autoreload': True,
  #'allow-root': True
}
c.ServerApp.jpserver_extensions = {
  "my_extension": True
}