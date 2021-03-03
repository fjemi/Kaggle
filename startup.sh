#!/bin/bash

cmd='''jupyter lab 
  --allow-root 
  --autoreload 
  --no-browser
'''

#cmd='''pipenv run jupyter lab --allow-root --autoreload --no-browser'''

eval $cmd
