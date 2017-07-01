#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive

docker build -t dtru_setup:latest .
