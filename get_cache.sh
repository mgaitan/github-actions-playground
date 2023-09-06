#!/usr/bin/env bash
docker build . -t the-python-app:req-download --target requirements-download --progress plain
id=$(docker create the-python-app:req-download)
docker cp $id:/root/.cache/pip .pip_cache
docker rm -v $id
# puto el que lee