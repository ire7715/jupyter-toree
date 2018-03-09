#!/bin/bash

sed -i 's/JUPYTER_AUTH_TOKEN/'$JUPYTER_AUTH_TOKEN'/' /root/.jupyter/jupyter_notebook_config.py

jupyter notebook --allow-root >> /var/log/jupyter.log
