#!/bin/bash

cmd='''pipenv run jupyter lab 
  --allow-root 
  --autoreload 
  --no-browser
'''

eval $cmd
