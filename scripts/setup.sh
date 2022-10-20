#!/usr/bin/env bash

set -e

PROJECT_NAME="python_starter"
PYTHON_VERSION="3.10.4"
PIP="python3 -m pip"

# Use project root as working directory
cd "$(dirname -- "$0";)/.." || exit 1

if ! pyenv --version; then
  echo "Install pyenv"
  exit 1
fi

if ! pyenv virtualenv --version; then
  echo "Install pyenv-virtualenv"
  exit 1
fi

if ! $PIP --version; then
  echo "Install pip"
  exit 1
fi

pyenv install --skip-existing $PYTHON_VERSION
pyenv local $PYTHON_VERSION
pyenv uninstall -f $PROJECT_NAME
pyenv virtualenv $PYTHON_VERSION $PROJECT_NAME -f
pyenv local $PROJECT_NAME

$PIP install --upgrade pip
$PIP install wheel
$PIP install -r requirements.txt

pyenv rehash

pre-commit install
pre-commit run &> /dev/null # Run once to initialize environments
